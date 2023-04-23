import 'package:feathersjs_demo_app/global.dart';
import 'package:feathersjs_demo_app/screens/login.dart';
import 'package:feathersjs_demo_app/screens/messages.dart';
import 'package:feathersjs_demo_app/screens/widgets/loading.dart';
import 'package:feathersjs_demo_app/services/auth.dart';
import 'package:feathersjs_demo_app/validators.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email;
  late String password;

  bool shouldValidate = false;
  bool isRegistering = false;
  late LabeledGlobalKey<FormState> key = LabeledGlobalKey<FormState>("RegistrationForm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                'Register',
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
                      return "Please enter a valid email";
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
                  const SizedBox(height: 30.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            backgroundColor: const Color(0xff447def),
                          ),
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              setState(() {
                                isRegistering = true;
                              });
                              AuthAPI auth = AuthAPI();
                              final response = await auth.registerUser(email, password);
                              setState(() {
                                isRegistering = false;
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
                          child: isRegistering
                              ? const MiniCPI()
                              : const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      ' Sign In',
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
