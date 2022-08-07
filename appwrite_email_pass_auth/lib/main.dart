import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:appwrite_flutter/providers/appwrite_provider.dart';
import 'package:appwrite_flutter/screens/home_screen.dart';
import 'package:appwrite_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppwriteProvider>(
      lazy: false,
      create: (BuildContext context) => AppwriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const RouteSet(),
      ),
    );
  }
}

class RouteSet extends StatefulWidget {
  const RouteSet({Key? key}) : super(key: key);

  @override
  State<RouteSet> createState() => _RouteSetState();
}

class _RouteSetState extends State<RouteSet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Provider.of<AppwriteProvider>(context).checkIfLoggedIn(),
      builder: (context, snapshot) {
        log(snapshot.hasData.toString());
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return HomeScreen(
              user: snapshot.data!,
            );
          } else {
            return const LoginScreen();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
