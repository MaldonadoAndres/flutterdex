abstract interface class Failure {
  final String message;
  const Failure(this.message);
}

/// Generic failures
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "An unknown error occurred"]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server error"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = "Request timed out"]);
}

class ParsingFailure extends Failure {
  const ParsingFailure([super.message = "Data parsing error"]);
}

/// Data / Cache
class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache read/write error"]);
}

class NoDataFailure extends Failure {
  const NoDataFailure([super.message = "No data found"]);
}
