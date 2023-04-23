import 'package:feathersjs_demo_app/global.dart';
import 'package:feathersjs_demo_app/screens/messages.dart';
import 'package:feathersjs_demo_app/screens/register.dart';
import 'package:feathersjs_demo_app/screens/widgets/loading.dart';
import 'package:feathersjs_demo_app/services/auth.dart';
import 'package:feathersjs_demo_app/validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  late LabeledGlobalKey<FormState> key = LabeledGlobalKey<FormState>("LoginForm");

  bool shouldValidate = false;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: shouldValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        key: key,
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 50.0),
              ),
              Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (Validators.isEmail(value)) {
                        return null;
                      }
                      return "Please enter valid email";
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (Validators.isPassword(value)) {
                        return null;
                      }
                      return "Please enter a strong password";
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            backgroundColor: const Color(0xff447def),
                          ),
                          onPressed: isLoggingIn
                              ? null
                              : () async {
                                  setState(() {
                                    shouldValidate = true;
                                  });
                                  if (key.currentState!.validate()) {
                                    key.currentState!.save();
                                    setState(() {
                                      isLoggingIn = true;
                                    });
                                    AuthAPI auth = AuthAPI();
                                    final response = await auth.loginUser(email, password);
                                    setState(() {
                                      isLoggingIn = false;
                                    });
                                    if (response.errorMessage == null) {
                                      logger.i(response.data!.toString());
                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const MessagesScreen();
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(response.errorMessage!),
                                            elevation: 2,
                                            duration: const Duration(seconds: 3),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.all(5),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                          child: isLoggingIn
                              ? const MiniCPI()
                              : const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegisterScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
