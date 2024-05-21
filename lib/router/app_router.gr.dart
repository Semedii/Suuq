// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:suuq/models/cart_product.dart' as _i15;
import 'package:suuq/models/product.dart' as _i16;
import 'package:suuq/pages/cart_page.dart' as _i2;
import 'package:suuq/pages/checkout_page/check_out_page.dart' as _i3;
import 'package:suuq/pages/checkout_page/confirmation_page.dart' as _i4;
import 'package:suuq/pages/homepage/home_page.dart' as _i5;
import 'package:suuq/pages/homepage/show_all_page.dart' as _i10;
import 'package:suuq/pages/login_page.dart' as _i6;
import 'package:suuq/pages/main_page.dart' as _i7;
import 'package:suuq/pages/order_history_page.dart' as _i8;
import 'package:suuq/pages/product_page.dart' as _i9;
import 'package:suuq/pages/signup_page.dart' as _i11;
import 'package:suuq/pages/welcome_page.dart' as _i12;
import 'package:suuq/router/authentication_wrapper.dart' as _i1;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    CartRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CartPage(),
      );
    },
    CheckOutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckOutRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CheckOutPage(
          key: args.key,
          cartProductList: args.cartProductList,
          totalAmount: args.totalAmount,
        ),
      );
    },
    ConfirmationRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ConfirmationPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MainPage(),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.OrderHistoryPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ProductPage(
          args.product,
          key: args.key,
        ),
      );
    },
    ShowAllRoute.name: (routeData) {
      final args = routeData.argsAs<ShowAllRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ShowAllPage(
          categoryName: args.categoryName,
          products: args.products,
          key: args.key,
        ),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.SignupPage(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WelcomePage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i13.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i13.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CartPage]
class CartRoute extends _i13.PageRouteInfo<void> {
  const CartRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CheckOutPage]
class CheckOutRoute extends _i13.PageRouteInfo<CheckOutRouteArgs> {
  CheckOutRoute({
    _i14.Key? key,
    required List<_i15.CartProduct?> cartProductList,
    required double totalAmount,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          CheckOutRoute.name,
          args: CheckOutRouteArgs(
            key: key,
            cartProductList: cartProductList,
            totalAmount: totalAmount,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckOutRoute';

  static const _i13.PageInfo<CheckOutRouteArgs> page =
      _i13.PageInfo<CheckOutRouteArgs>(name);
}

class CheckOutRouteArgs {
  const CheckOutRouteArgs({
    this.key,
    required this.cartProductList,
    required this.totalAmount,
  });

  final _i14.Key? key;

  final List<_i15.CartProduct?> cartProductList;

  final double totalAmount;

  @override
  String toString() {
    return 'CheckOutRouteArgs{key: $key, cartProductList: $cartProductList, totalAmount: $totalAmount}';
  }
}

/// generated route for
/// [_i4.ConfirmationPage]
class ConfirmationRoute extends _i13.PageRouteInfo<void> {
  const ConfirmationRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmationRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainPage]
class MainRoute extends _i13.PageRouteInfo<void> {
  const MainRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OrderHistoryPage]
class OrderHistoryRoute extends _i13.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ProductPage]
class ProductRoute extends _i13.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required _i16.Product product,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const _i13.PageInfo<ProductRouteArgs> page =
      _i13.PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    required this.product,
    this.key,
  });

  final _i16.Product product;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ProductRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i10.ShowAllPage]
class ShowAllRoute extends _i13.PageRouteInfo<ShowAllRouteArgs> {
  ShowAllRoute({
    required String categoryName,
    required List<_i16.Product?> products,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ShowAllRoute.name,
          args: ShowAllRouteArgs(
            categoryName: categoryName,
            products: products,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ShowAllRoute';

  static const _i13.PageInfo<ShowAllRouteArgs> page =
      _i13.PageInfo<ShowAllRouteArgs>(name);
}

class ShowAllRouteArgs {
  const ShowAllRouteArgs({
    required this.categoryName,
    required this.products,
    this.key,
  });

  final String categoryName;

  final List<_i16.Product?> products;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ShowAllRouteArgs{categoryName: $categoryName, products: $products, key: $key}';
  }
}

/// generated route for
/// [_i11.SignupPage]
class SignupRoute extends _i13.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i13.PageInfo<SignupRouteArgs> page =
      _i13.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.WelcomePage]
class WelcomeRoute extends _i13.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          WelcomeRoute.name,
          args: WelcomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i13.PageInfo<WelcomeRouteArgs> page =
      _i13.PageInfo<WelcomeRouteArgs>(name);
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}
