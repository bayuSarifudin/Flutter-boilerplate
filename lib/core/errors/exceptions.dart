/// Exception dasar untuk error teknis di lapisan Data (API/Database).
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ServerException(statusCode: $statusCode, message: $message)';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'Koneksi internet bermasalah. Periksa jaringan Anda.',
  });

  @override
  String toString() => 'NetworkException(message: $message)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = 'Gagal memproses data lokal.',
  });

  @override
  String toString() => 'CacheException(message: $message)';
}

class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({
    this.message = 'Sesi Anda telah berakhir. Silakan login kembali.',
  });

  @override
  String toString() => 'UnauthorizedException(message: $message)';
}