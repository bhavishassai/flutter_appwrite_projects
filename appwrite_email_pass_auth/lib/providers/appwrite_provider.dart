import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';

class AppwriteProvider extends ChangeNotifier {
  late Client _client;
  late Account _account;
  late User _user;
  AppwriteProvider() {
    _init();
  }

  void _init() {
    _client = Client();
    _client
        .setEndpoint("[ENDPOINT]")
        .setProject("[PROJECT_ID]")
        .setSelfSigned(status: true);
    _account = Account(_client);
  }

  Future<User?> checkIfLoggedIn() async {
    try {
      _user = await _account.get();
      return Future.value(_user);
    } catch (e) {
      log(e.toString());
      return Future.value(null);
    }
  }

  Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      await _account.createEmailSession(email: email, password: password);
      _user = await _account.get();
      return Future.value(_user);
    } catch (e) {
      log(e.toString());
      return Future.value(null);
    }
  }

  Future<User?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      _user = await _account.create(
        userId: "unique()",
        email: email,
        password: password,
        name: name,
      );
      return Future.value(_user);
    } catch (e) {
      log(e.toString());
      return Future.value(null);
    }
  }

  Future<bool> logoutUser() async {
    try {
      await _account.deleteSession(sessionId: "current");
      return Future.value(true);
    } catch (e) {
      log(e.toString());
      return Future.value(false);
    }
  }
}
