import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import 'package:zikr_app/core/utils/app_logger.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  static const String _tokenKey = 'auth_token';

  AuthCubit({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    logger.i('checkAuthStatus started', tag: 'AuthCubit');
    emit(state.copyWith(status: AuthStatus.loading));
    
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    
    if (token == null || token.isEmpty) {
      logger.w('checkAuthStatus: no token found', tag: 'AuthCubit');
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }
    
    final result = await getCurrentUser(NoParams());
    result.fold(
      (failure) {
        logger.w('checkAuthStatus failed', tag: 'AuthCubit', data: failure.message);
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (user) {
        logger.i('checkAuthStatus success', tag: 'AuthCubit', data: {'userId': user?.id});
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    logger.i('signIn started', tag: 'AuthCubit', data: {'email': email});
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signInWithEmail(SignInParams(email: email, password: password));
    result.fold(
      (failure) {
        logger.e('signIn failed', tag: 'AuthCubit', data: failure.message);
        emit(state.copyWith(status: AuthStatus.error, message: failure.message));
      },
      (user) async {
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_tokenKey, user.id);
        }
        logger.i('signIn success', tag: 'AuthCubit', data: {'userId': user?.id});
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  Future<void> signUp(String email, String password, String displayName) async {
    logger.i('signUp started', tag: 'AuthCubit', data: {'email': email, 'name': displayName});
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signUpWithEmail(SignUpParams(email: email, password: password, displayName: displayName));
    result.fold(
      (failure) {
        logger.e('signUp failed', tag: 'AuthCubit', data: failure.message);
        emit(state.copyWith(status: AuthStatus.error, message: failure.message));
      },
      (user) {
        logger.i('signUp success', tag: 'AuthCubit', data: {'userId': user?.id});
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  Future<void> logout() async {
    logger.i('logout started', tag: 'AuthCubit');
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await signOut(NoParams());
    result.fold(
      (failure) {
        logger.e('logout failed', tag: 'AuthCubit', data: failure.message);
        emit(state.copyWith(status: AuthStatus.error, message: failure.message));
      },
      (_) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_tokenKey);
        logger.i('logout success', tag: 'AuthCubit');
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      },
    );
  }
}