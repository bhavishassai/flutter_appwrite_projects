import 'package:appwrite/models.dart';
import 'package:appwrite_flutter/providers/appwrite_provider.dart';
import 'package:appwrite_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(user.registration * 1000))
        .toString();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome ${user.name}\nRegistration : $date",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppwriteProvider>(context, listen: false)
                  .logoutUser()
                  .then(
                (value) {
                  if (value) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        margin: const EdgeInsets.all(16),
                        backgroundColor: Colors.red,
                        content: const Text("Logout failed !"),
                      ),
                    );
                  }
                },
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
