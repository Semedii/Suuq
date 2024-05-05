// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i10;
import 'package:suuq/models/product.dart' as _i9;
import 'package:suuq/pages/homepage/home_page.dart' as _i2;
import 'package:suuq/pages/login_page.dart' as _i3;
import 'package:suuq/pages/main_page.dart' as _i4;
import 'package:suuq/pages/product_page.dart' as _i5;
import 'package:suuq/pages/signup_page.dart' as _i6;
import 'package:suuq/pages/welcome_page.dart' as _i7;
import 'package:suuq/router/authentication_wrapper.dart' as _i1;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MainPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ProductPage(
          args.product,
          key: args.key,
        ),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SignupPage(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.WelcomePage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i8.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i8.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MainPage]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProductPage]
class ProductRoute extends _i8.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required _i9.Product product,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const _i8.PageInfo<ProductRouteArgs> page =
      _i8.PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    required this.product,
    this.key,
  });

  final _i9.Product product;

  final _i10.Key? key;

  @override
  String toString() {
    return 'ProductRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i6.SignupPage]
class SignupRoute extends _i8.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i8.PageInfo<SignupRouteArgs> page =
      _i8.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.WelcomePage]
class WelcomeRoute extends _i8.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          WelcomeRoute.name,
          args: WelcomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i8.PageInfo<WelcomeRouteArgs> page =
      _i8.PageInfo<WelcomeRouteArgs>(name);
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}
