import 'package:flutter/material.dart';
import 'package:zikr_app/core/navigation/route_generator.dart';
import 'package:zikr_app/core/navigation/route_names.dart';

/// A global navigation service that wraps a navigator key for imperative navigation from non-widget code.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    final res = navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
    return res ?? Future<T?>.value(null);
  }

  Future<void> navigateToCollection(CollectionPageArgs args) {
    return navigatorKey.currentState?.pushNamed(
          AppRoutes.collection,
          arguments: args,
        ) ??
        Future.value();
  }

  void goBack<T extends Object?>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop<T>(result);
    }
  }
}
