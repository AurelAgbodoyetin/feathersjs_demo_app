class API {
  static const baseUrl = "https://feathersjs.dah-kenangnon.com/";
  static const secret = "00a11be53e71608c37c1653f28adfd1bcff089abb15e6c0cacbae0da02934d9b";
}

class APIResponse<T> {
  final String? errorMessage;
  final T? data;
  APIResponse({
    required this.errorMessage,
    required this.data,
  }) : assert(
          (errorMessage == null && data != null) || (errorMessage != null && data == null),
        );
}
