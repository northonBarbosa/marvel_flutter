abstract class AppError implements Exception {
  String? message;
  String? stackTrace;

  @override
  String toString() {
    return message!;
  }
}

class AppApiRepositoryError extends AppError {
  AppApiRepositoryError(String message, String classNameAndFunction) {
    this.message = '$message \n\n$classNameAndFunction\n';
    stackTrace = StackTrace.current.toString();
  }
}
