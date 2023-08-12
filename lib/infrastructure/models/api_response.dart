class ApiResponse<T> {
  final bool _isSuccess;
  final String _message;
  final T? _data;

  ApiResponse({
    required bool isSuccess,
    required String message,
    T? data,
  })  : _data = data,
        _message = message,
        _isSuccess = isSuccess;

  bool get isSuccess => _isSuccess;

  String get message => _message;

  T? get data => _data;
}
