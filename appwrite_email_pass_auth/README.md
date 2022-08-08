### Implementing Email-Password authentication using Appwrite


```dart
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
        .setEndpoint("[ENDPOINT]")  // specify your appwrite server endpoint
        .setProject("[PROJECT_ID]") // your project id
        .setSelfSigned(status: true); // set self signed to true in dev
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
```
