import 'status.dart';

class ApiResponse<T> {
  // Parameterized Class (Generick Class)
  final Status? status;
  T? data;
  String? message;

  // Parameterized Constructor
  ApiResponse([this.status, this.data, this.message]);

  // Named Constructor
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\n Error: $message\n Data: $data";
  }
}
