import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_infinity_app/core/config/appwrite_config.dart';
import 'package:todo_infinity_app/core/config/storage_key.dart';
import 'package:todo_infinity_app/core/errors/failure.dart';
import 'package:todo_infinity_app/core/errors/server_exception.dart';
import 'package:todo_infinity_app/core/locator/locator.dart';
import 'package:todo_infinity_app/data/providers/appwrite_provider.dart';
import 'package:todo_infinity_app/data/models/category_model.dart';
import 'package:todo_infinity_app/data/services/storage_service.dart';

class MainCategoryModel {
  //? a list of categories
  final AppwriteProvider _appwriteProvider = locator<AppwriteProvider>();
  final InternetConnectionChecker _connectionChecker =
      locator<InternetConnectionChecker>();
  final StorageService _storageService = locator<StorageService>();
  List<CategoryModel> categoryList = [];
  String errorMessage = '';
  Future<Either<Failure, List<CategoryModel>>> getCategory(
      {required String userId}) async {
    try {
      if (await _connectionChecker.hasConnection) {
        DocumentList documentList = await _appwriteProvider.databases!
            .listDocuments(
                databaseId: AppwriteConfig.databaseId,
                collectionId: AppwriteConfig.categoryCollectionId,
                queries: [Query.equal("userId", userId)]);
        Map<String, dynamic> data = documentList.toMap();

        List list = data['documents'].toList();

        categoryList =
            list.map((e) => CategoryModel.fromMap(e['data'])).toList();

        for (final category in categoryList) {
          final completedTodos =
              await _appwriteProvider.databases!.listDocuments(
            databaseId: AppwriteConfig.databaseId,
            collectionId: AppwriteConfig.todoCollectionId,
            queries: [
              Query.equal('categoryId', category.id),
              Query.equal(
                'userId',
                _storageService.getValue(
                  StorageKey.userId,
                ),
              ),
              Query.equal('isComplete', true),
            ],
          );
          final totalTodos = await _appwriteProvider.databases!.listDocuments(
            databaseId: AppwriteConfig.databaseId,
            collectionId: AppwriteConfig.todoCollectionId,
            queries: [
              Query.equal('categoryId', category.id),
              Query.equal(
                'userId',
                _storageService.getValue(
                  StorageKey.userId,
                ),
              ), // فیلتر بر اساس userId
            ],
          );
          final int total = totalTodos.total;
          final int completed = completedTodos.total;
          final double percentage = total > 0 ? (completed / total) * 100 : 0;
          category.totalTodos = total;
          category.completedTodos = completed;
          log('total: $total completed: $completed percentage: $percentage');
        }
        return right(categoryList);
      } else {
        return left(Failure('Check Internet Connection'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, Document>> addCategory(
      {required String userId,
      required String title,
      required int iconIndex,
      required int colorIndex}) async {
    try {
      if (await _connectionChecker.hasConnection) {
        String documentId = ID.unique();
        Document document = await _appwriteProvider.databases!.createDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.categoryCollectionId,
          documentId: documentId,
          data: {
            "userId": userId,
            "title": title,
            "icon_index": iconIndex,
            "color_index": colorIndex,
            "id": documentId
          },
        );
        categoryList.add(CategoryModel(
            id: documentId,
            title: title,
            iconIndex: iconIndex,
            colorIndex: colorIndex));
        log(document.toString());
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
}
