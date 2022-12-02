class FailedLoadError extends Error {
  String message;

  FailedLoadError({this.message = ""});

  @override
  String toString() => message;
}