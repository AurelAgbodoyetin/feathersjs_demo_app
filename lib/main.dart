import 'package:dio/dio.dart';
import 'package:feathersjs_demo_app/screens/login.dart';
import 'package:feathersjs_demo_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';

FlutterFeathersjs flutterFeathersJS = FlutterFeathersjs();

void main() {
  Dio dio = Dio(BaseOptions(baseUrl: API.baseUrl, headers: {"auth-demo": API.secret}));
  //flutterFeathersjs.configure(FlutterFeathersjs.restClient(dio));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFeathersJS Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Abel",
        scaffoldBackgroundColor: const Color(0xffF5F5F3),
      ),
      home: const LoginScreen(),
    );
  }
}
