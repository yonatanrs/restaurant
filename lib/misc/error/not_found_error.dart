class NotFoundError extends Error {
  String message;

  NotFoundError({this.message = ""});

  @override
  String toString() => message;
}