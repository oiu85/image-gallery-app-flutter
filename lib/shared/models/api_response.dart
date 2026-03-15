class ApiResponse<T> {
  const ApiResponse({required this.success, this.data, this.message});

  final bool success;
  final T? data;
  final String? message;

  factory ApiResponse.success(T data) => ApiResponse(success: true, data: data);

  factory ApiResponse.failure(String message) => ApiResponse(success: false, message: message);
}
