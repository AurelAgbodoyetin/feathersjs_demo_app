import 'package:dio/dio.dart';
import 'package:feathersjs_demo_app/screens/login.dart';
import 'package:feathersjs_demo_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
//import 'package:socket_io_client/socket_io_client.dart' as socket;

FlutterFeathersjs flutterFeathersJS = FlutterFeathersjs();
//..init(baseUrl: API.baseUrl, extraHeaders: {"auth-demo": API.secret});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Dio dio = Dio(BaseOptions(baseUrl: API.baseUrl, headers: {"auth-demo": API.secret}));
  flutterFeathersJS.configure(FlutterFeathersjs.restClient(dio));

/*   socket.Socket io = socket.io(API.baseUrl);
  flutterFeathersJS.configure(FlutterFeathersjs.socketioClient(io)); */
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
