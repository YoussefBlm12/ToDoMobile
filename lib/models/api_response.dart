class   APIJsonResponse<T> {
  T? data;
  bool error;
  String message;
  bool unauthorized;
  int? statusCode;

  APIJsonResponse({
    this.data,
    this.message = '',
    this.error = false,
    this.unauthorized = false,
    this.statusCode,
  });
}

class APIResponse<T> {
  T? data;
  bool error;
  String message;
  bool unauthorized;

  APIResponse({
    this.data,
    this.message = '',
    this.error = false,
    this.unauthorized = false,
  });
}
