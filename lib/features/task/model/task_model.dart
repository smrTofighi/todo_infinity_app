import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_infinity_app/core/config/appwrite_config.dart';
import 'package:todo_infinity_app/core/config/storage_key.dart';
import 'package:todo_infinity_app/core/errors/failure.dart';
import 'package:todo_infinity_app/core/errors/server_exception.dart';
import 'package:todo_infinity_app/core/locator/locator.dart';
import 'package:todo_infinity_app/data/models/category_model.dart';
import 'package:todo_infinity_app/data/models/todo_model.dart';
import 'package:todo_infinity_app/data/providers/appwrite_provider.dart';
import 'package:todo_infinity_app/data/services/storage_service.dart';

class TaskModel {
  late CategoryModel categoryModel;

  final _appwrite = locator<AppwriteProvider>();
  final _connectionChecker = locator<InternetConnectionChecker>();
  final _storageService = locator<StorageService>();
  final RxString alarm = RxString('');
  final RxString description = RxString('');

  Future<Either<Failure, dynamic>> deleteTodo(
      {required String id, required bool isCompleted}) async {
    try {
      if (await _connectionChecker.hasConnection) {
        var document = await _appwrite.databases!.deleteDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.todoCollectionId,
          documentId: id,
        );
        if (isCompleted == false) {
          categoryModel.activeTodos!.removeWhere((element) => element.id == id);
        } else {
          categoryModel.unActiveTodos!
              .removeWhere((element) => element.id == id);
          categoryModel.completedTodos = categoryModel.completedTodos - 1;
        }
        categoryModel.totalTodos = categoryModel.totalTodos - 1;

        return right(document);
      } else {
        return left(Failure('Check Internet Connection'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, Document>> addTodo({
    required String title,
    required bool isCompleted,
  }) async {
    try {
      if (await _connectionChecker.hasConnection) {
        String documentId = ID.unique();
        Document document = await _appwrite.databases!.createDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.todoCollectionId,
          documentId: documentId,
          data: {
            "userId": _storageService.getValue(StorageKey.userId),
            "title": title,
            "description": description.value,
            "isComplete": isCompleted,
            'categoryId': categoryModel.id,
            "id": documentId,
          },
        );
        categoryModel.activeTodos!.add(
            TodoModel(id: documentId, title: title, isComplete: isCompleted));
        categoryModel.totalTodos = categoryModel.totalTodos + 1;
        return right(document);
      } else {
        return left(Failure('Check Internet Connection'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, Document>> updateTodo(
      {required String documentId,
      required String title,
      required bool isCompleted,
      required int index}) async {
    try {
      if (await _connectionChecker.hasConnection) {
        Document document = await _appwrite.databases!.updateDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.todoCollectionId,
          documentId: documentId,
          data: {
            "title": title,
            "isComplete": isCompleted,
            "description": description.value
          },
        );
        if (isCompleted == false) {
          categoryModel.activeTodos![index]
            ..title = title
            ..description = description.value;
        } else {
          categoryModel.unActiveTodos![index]
            ..title = title
            ..description = description.value;
        }
        log(document.data.toString());
        return right(document);
      } else {
        return left(Failure('Check Internet Connection'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, List<TodoModel>>> getTodoList() async {
    try {
      if (await _connectionChecker.hasConnection) {
        DocumentList responseActiveTodo =
            await _appwrite.databases!.listDocuments(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.todoCollectionId,
          queries: [
            Query.equal(
              'userId',
              _storageService.getValue(StorageKey.userId),
            ),
            Query.equal('categoryId', categoryModel.id),
            Query.equal('isComplete', false)
          ],
        );
        DocumentList responseUnActiveTodo =
            await _appwrite.databases!.listDocuments(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.todoCollectionId,
          queries: [
            Query.equal(
              'userId',
              _storageService.getValue(StorageKey.userId),
            ), // فیلتر بر اساس userId
            Query.equal('categoryId', categoryModel.id),
            Query.equal('isComplete', true)
          ],
        );
        log(responseActiveTodo.documents.toString());
        categoryModel.unActiveTodos = responseUnActiveTodo.documents
            .map((doc) => TodoModel.fromMap(doc.data))
            .toList()
            .obs;

        categoryModel.activeTodos = responseActiveTodo.documents
            .map((doc) => TodoModel.fromMap(doc.data))
            .toList()
            .obs;

        return right(categoryModel.activeTodos!);
      } else {
        return left(Failure('Check Your Internet Connection'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, Document>> updateIsCompleted(
      {required String id, required bool isComplete}) async {
    try {
      final document = await _appwrite.databases!.updateDocument(
        collectionId: AppwriteConfig.todoCollectionId,
        databaseId: AppwriteConfig.databaseId,
        documentId: id,
        data: {
          'isComplete': isComplete,
        },
      );
      if (!isComplete == false) {
        var todo = categoryModel.activeTodos!
            .firstWhere((element) => element.id == id);
        todo.isComplete = isComplete;
        categoryModel.activeTodos!.remove(todo);
        categoryModel.unActiveTodos!.add(todo);
      } else {
        var todo = categoryModel.unActiveTodos!
            .firstWhere((element) => element.id == id);
        todo.isComplete = isComplete;
        categoryModel.unActiveTodos!.remove(todo);
        categoryModel.activeTodos!.add(todo);
        categoryModel.completedTodos = categoryModel.completedTodos - 1;
      }
      log(document.data.toString());
      return right(document);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
