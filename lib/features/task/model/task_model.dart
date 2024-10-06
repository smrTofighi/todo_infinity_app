
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
  Future<Either<Failure, Document>> addTodo({
    required String title,
    required bool isCompleted,
    DateTime? time,
    int? priority,
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
            'time': time,
            'priority': priority,
            'categoryId': categoryModel.id,
            "id": documentId,
          },
        );

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
            ), // فیلتر بر اساس userId
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
            Query.equal('isComplete', true)
          ],
        );
        log(responseActiveTodo.documents.toString());
        categoryModel.unActiveTodos = responseUnActiveTodo.documents
            .map((doc) => TodoModel.fromMap(doc.data))
            .toList().obs;

        categoryModel.activeTodos = responseActiveTodo.documents
            .map((doc) => TodoModel.fromMap(doc.data))
            .toList().obs;
        log(categoryModel.activeTodos.toString());
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
}
