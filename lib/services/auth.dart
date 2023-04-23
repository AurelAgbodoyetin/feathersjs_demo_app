import 'package:feathersjs_demo_app/global.dart';
import 'package:feathersjs_demo_app/main.dart';
import 'package:feathersjs_demo_app/models/user.dart';
import 'package:feathersjs_demo_app/services/api.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';

class AuthAPI {
  Future<APIResponse<User>> loginUser(String email, String password) async {
    User? user;
    String? error;
    try {
      Map<String, dynamic> response = await flutterFeathersJS.authenticate(
        userName: email,
        password: password,
        strategy: "local",
      );
      logger.i(response);
      user = User.fromMap(response);
      // If all thing is ok, save user in local storage
      /*  await utils.setLoggedUser(user);
       */
    } on FeatherJsError catch (e) {
      if (e.type == FeatherJsErrorType.IS_INVALID_CREDENTIALS_ERROR) {
        logger.e("IS_INVALID_CREDENTIALS_ERROR");
        error = "Please check your credentials";
      } else if (e.type == FeatherJsErrorType.IS_INVALID_STRATEGY_ERROR) {
        logger.e("IS_INVALID_STRATEGY_ERROR");
      } else if (e.type == FeatherJsErrorType.IS_AUTH_FAILED_ERROR) {
        logger.e("IS_AUTH_FAILED_ERROR");
        error = "Unexpected error occured, please retry!";
      } else {
        logger.e("FeatherJsError error ::: Type => ${e.type} ::: Message => ${e.message}");
        error = "Unexpected FeatherJsError occured, please retry!";
      }
    } catch (e) {
      logger.e("Unexpected error ::: ${e.toString()}");
      error = "Unexpected error occured, please retry!";
    }
    return APIResponse(errorMessage: error, data: user);
  }

  Future<APIResponse<User>> registerUser(String email, String password) async {
    User? user;
    String? error;
    try {
      Map<String, dynamic> response = await flutterFeathersJS.create(
        serviceName: "users",
        data: {"email": email, "password": password},
      );
      logger.i(response.toString());
      user = User.fromMap(response);
      await loginUser(email, password);
    } on FeatherJsError catch (e) {
      if (e.type == FeatherJsErrorType.IS_INVALID_CREDENTIALS_ERROR) {
        logger.e("IS_INVALID_CREDENTIALS_ERROR");
        error = "Please check your credentials";
      } else if (e.type == FeatherJsErrorType.IS_INVALID_STRATEGY_ERROR) {
        logger.e("IS_INVALID_STRATEGY_ERROR");
      } else if (e.type == FeatherJsErrorType.IS_AUTH_FAILED_ERROR) {
        logger.e("IS_AUTH_FAILED_ERROR");
        error = "Unexpected error occured, please retry!";
      } else {
        logger.e("FeatherJsError error ::: Type => ${e.type} ::: Message => ${e.message}");
        error = "Unexpected FeatherJsError occured, please retry!";
      }
    } catch (e) {
      logger.e("Unexpected error ::: ${e.toString()}");
      error = "Unexpected error occured, please retry!";
    }
    return APIResponse(errorMessage: error, data: user);
  }
}
