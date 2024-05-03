// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:suuq/pages/login_page.dart' as _i2;
import 'package:suuq/pages/signup_page.dart' as _i3;
import 'package:suuq/pages/welcome_page.dart' as _i4;
import 'package:suuq/router/authentication_wrapper.dart' as _i1;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SignupPage(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.WelcomePage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i5.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i5.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i5.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i5.PageInfo<SignupRouteArgs> page =
      _i5.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.WelcomePage]
class WelcomeRoute extends _i5.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          WelcomeRoute.name,
          args: WelcomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i5.PageInfo<WelcomeRouteArgs> page =
      _i5.PageInfo<WelcomeRouteArgs>(name);
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}
