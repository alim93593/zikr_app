import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await repository.getProfile();

    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, message: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.loaded, profile: profile)),
    );
  }

  Future<void> updateProfile(String displayName, String? photoUrl) async {
    if (state.profile == null) return;

    final updated = state.profile!.copyWith(
      displayName: displayName,
      photoUrl: photoUrl,
    );

    final result = await repository.updateProfile(updated);

    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (_) => emit(state.copyWith(profile: updated)),
    );
  }
}