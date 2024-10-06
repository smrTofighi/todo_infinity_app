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
import 'package:todo_infinity_app/data/services/storage_service.dart';

class AuthModel {
  final _connectionChecker = locator<InternetConnectionChecker>();
  final _appwrite = locator<AppwriteProvider>();
  final _storageService = locator<StorageService>();
  Future<Either<Failure, Session>> logInUser(
      {required String email, required String password}) async {
    try {
      if (await _connectionChecker.hasConnection) {
        var session = await _appwrite.account!.createEmailPasswordSession(
          email: email,
          password: password,
        );
        _storageService.setValue(StorageKey.userId, session.userId);
        _storageService.setValue(StorageKey.sessionId, session.$id);

        return right(session);
      } else {
        return left(Failure("Check Your Internet Connection"));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> signInUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      log(email);
      if (await _connectionChecker.hasConnection) {
        var user = await _appwrite.account!.create(
            userId: ID.unique(),
            email: email,
            password: password,
            name: "$firstName $lastName");
        await _appwrite.databases!.createDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.userCollectionId,
          documentId: user.$id,
          data: {
            "id": user.$id,
            "first_name": firstName,
            "last_name": lastName,
            "full_name": "$firstName $lastName",
            "email": email
          },
        );
        log(user.email.toString());
        return right(user);
      } else {
        return left(Failure("Check Your Internet Connection"));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  Future<Either<Failure, Session>> checkSession() async {
    try {
      if (await _connectionChecker.hasConnection) {
        final Session session =
            await _appwrite.account!.getSession(sessionId: "current");

        return right(session);
      } else {
        return left(Failure("Check Your Internet Connection"));
      }
    } on AppwriteException catch (e) {
      log( e.message!);
      return left(Failure(e.message!));
    } on ServerException catch (e) {
        log( e.message);
      return left(Failure(e.message));
    }
  }

 
    
  }

