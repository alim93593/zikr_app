import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/navigation/route_names.dart';
import 'package:zikr_app/core/shell/app_shell.dart';
import 'package:zikr_app/features/home/presentation/pages/collection_page.dart';
import 'package:zikr_app/features/profile/presentation/pages/profile_page.dart';
import 'package:zikr_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:zikr_app/features/auth/presentation/pages/login_page.dart';
import 'package:zikr_app/features/auth/presentation/pages/register_page.dart';
import 'package:zikr_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zikr_app/features/splash/presentation/pages/splash_page.dart';
import 'package:zikr_app/features/admin/presentation/pages/manage_zikir_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: di.sl<AuthCubit>(),
          child: const SplashPage(),
        ),
      );
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const AppShell());
    case AppRoutes.profile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case AppRoutes.manageZikir:
      return MaterialPageRoute(builder: (_) => const ManageZikirPage());
    case AppRoutes.editProfile:
      return MaterialPageRoute(builder: (_) => const EditProfilePage());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case AppRoutes.collection:
      final args = settings.arguments;
      if (args is CollectionPageArgs) {
        return MaterialPageRoute(
          builder: (_) => CollectionPage(item: args.item),
        );
      }
      return MaterialPageRoute(builder: (_) => const AppShell());
    default:
      return MaterialPageRoute(builder: (_) => const SplashPage());
  }
}

class CollectionPageArgs {
  final dynamic item;
  CollectionPageArgs(this.item);
}