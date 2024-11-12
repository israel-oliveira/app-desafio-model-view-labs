sealed class RandomException implements Exception {
  final String message;

  RandomException({required this.message});
}

final class RandomError extends RandomException {
  RandomError({required super.message});
}

final class RandomUnavailable extends RandomException {
  RandomUnavailable({required super.message});
}
