import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user_entity.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? message;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}