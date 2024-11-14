sealed class ValidateException implements Exception {
  final String message;

  ValidateException({required this.message});
}

class ValidateFailed extends ValidateException{
  ValidateFailed({required super.message});
}

class EntityValidate extends ValidateException {
  EntityValidate({required super.message});
}

class ValidateError extends ValidateException {
  ValidateError({required super.message});
}