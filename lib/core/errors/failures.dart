import 'package:equatable/equatable.dart';

/// Kelas dasar Failure untuk dikonsumsi oleh lapisan Domain dan UI (Bloc).
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.',
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Gagal membaca atau menyimpan data di perangkat.',
  });
}

class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Sesi telah habis atau otorisasi ditolak.',
    super.statusCode = 401,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}