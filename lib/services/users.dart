import 'package:feathersjs_demo_app/global.dart';
import 'package:feathersjs_demo_app/main.dart';
import 'package:feathersjs_demo_app/models/user.dart';
import 'package:feathersjs_demo_app/services/api.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';

class UsersAPI {
  Future<APIResponse<List<User>>> getUsers() async {
    List<User>? users;
    String? error;
    try {
      Map<String, dynamic> response = await flutterFeathersJS.rest.find(
        serviceName: "users",
        query: {},
      );
      logger.i(response.toString());
      users = List<Map<String, dynamic>>.from(response["data"])
          .map((map) => User.fromMap(map))
          .toList();
    } on FeatherJsError catch (e) {
      logger.e("FeatherJsError error ::: Type => ${e.type} ::: Message => ${e.message}");
      error = "Unexpected FeatherJsError occured, please retry!";
    } catch (e) {
      logger.e("Unexpected error ::: ${e.toString()}");
      error = "Unexpected error occured, please retry!";
    }
    return APIResponse(errorMessage: error, data: users);
  }
}
