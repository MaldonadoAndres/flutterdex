//Networking Exceptions
class ServerException implements Exception {} // HTTP 500, parsing errors

class UnauthorizedException implements Exception {} // HTTP 401, expired token

class ForbiddenException
    implements Exception {} // HTTP 403, insufficient rights

class NotFoundException implements Exception {} // HTTP 404

class BadRequestException implements Exception {} // HTTP 400

class NetworkException implements Exception {}

//Local Storage/Cache Exception

class CacheException implements Exception {
  String? message;
  CacheException([this.message]);
} // Failed reading from local DB

class WriteCacheException implements Exception {} // Failed writing to local DB

class NoCachedDataException
    implements Exception {} // Tried to get cache but it’s empty
