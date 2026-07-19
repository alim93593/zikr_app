import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entity.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileEntity? profile;
  final String? message;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.message,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileEntity? profile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, profile, message];
}