class DataResponse<T> {
  final T? data;
  final String? message;
  final bool isSuccess;

  DataResponse._({this.data, this.message, required this.isSuccess});

  factory DataResponse.success({String message = '', required T data}) {
    return DataResponse._(data: data, isSuccess: true, message: message);
  }

  factory DataResponse.error(String message) {
    return DataResponse._(message: message, isSuccess: false);
  }
}
