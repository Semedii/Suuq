// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:suuq/models/cart_product.dart' as _i19;
import 'package:suuq/models/product.dart' as _i20;
import 'package:suuq/pages/cart_page.dart' as _i2;
import 'package:suuq/pages/change_language_page.dart' as _i4;
import 'package:suuq/pages/change_password_page.dart' as _i5;
import 'package:suuq/pages/checkout_page/check_out_page.dart' as _i6;
import 'package:suuq/pages/checkout_page/confirmation_page.dart' as _i7;
import 'package:suuq/pages/full_photo_page.dart' as _i8;
import 'package:suuq/pages/homepage/category_page.dart' as _i3;
import 'package:suuq/pages/homepage/home_page.dart' as _i9;
import 'package:suuq/pages/login_page.dart' as _i10;
import 'package:suuq/pages/main_page.dart' as _i11;
import 'package:suuq/pages/order_history_page.dart' as _i12;
import 'package:suuq/pages/personal_information_page.dart' as _i13;
import 'package:suuq/pages/product_page.dart' as _i14;
import 'package:suuq/pages/signup_page.dart' as _i15;
import 'package:suuq/pages/welcome_page.dart' as _i16;
import 'package:suuq/router/authentication_wrapper.dart' as _i1;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    CartRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CartPage(),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CategoryPage(
          categoryName: args.categoryName,
          key: args.key,
        ),
      );
    },
    ChangeLanguageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChangeLanguagePage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ChangePasswordPage(key: args.key),
      );
    },
    CheckOutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckOutRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CheckOutPage(
          key: args.key,
          cartProductList: args.cartProductList,
          totalAmount: args.totalAmount,
        ),
      );
    },
    ConfirmationRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ConfirmationPage(),
      );
    },
    FullPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<FullPhotoRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.FullPhotoPage(
          imageUrl: args.imageUrl,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MainPage(),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.OrderHistoryPage(),
      );
    },
    PersonalInformationRoute.name: (routeData) {
      final args = routeData.argsAs<PersonalInformationRouteArgs>(
          orElse: () => const PersonalInformationRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.PersonalInformationPage(key: args.key),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ProductPage(
          args.product,
          key: args.key,
        ),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SignupPage(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.WelcomePage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i17.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i17.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CartPage]
class CartRoute extends _i17.PageRouteInfo<void> {
  const CartRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CategoryPage]
class CategoryRoute extends _i17.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    required String categoryName,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            categoryName: categoryName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i17.PageInfo<CategoryRouteArgs> page =
      _i17.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    required this.categoryName,
    this.key,
  });

  final String categoryName;

  final _i18.Key? key;

  @override
  String toString() {
    return 'CategoryRouteArgs{categoryName: $categoryName, key: $key}';
  }
}

/// generated route for
/// [_i4.ChangeLanguagePage]
class ChangeLanguageRoute extends _i17.PageRouteInfo<void> {
  const ChangeLanguageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChangeLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeLanguageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i17.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i17.PageInfo<ChangePasswordRouteArgs> page =
      _i17.PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.CheckOutPage]
class CheckOutRoute extends _i17.PageRouteInfo<CheckOutRouteArgs> {
  CheckOutRoute({
    _i18.Key? key,
    required List<_i19.CartProduct?> cartProductList,
    required double totalAmount,
    List<_i17.PageRouteInfo>? children,
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

  static const _i17.PageInfo<CheckOutRouteArgs> page =
      _i17.PageInfo<CheckOutRouteArgs>(name);
}

class CheckOutRouteArgs {
  const CheckOutRouteArgs({
    this.key,
    required this.cartProductList,
    required this.totalAmount,
  });

  final _i18.Key? key;

  final List<_i19.CartProduct?> cartProductList;

  final double totalAmount;

  @override
  String toString() {
    return 'CheckOutRouteArgs{key: $key, cartProductList: $cartProductList, totalAmount: $totalAmount}';
  }
}

/// generated route for
/// [_i7.ConfirmationPage]
class ConfirmationRoute extends _i17.PageRouteInfo<void> {
  const ConfirmationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmationRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FullPhotoPage]
class FullPhotoRoute extends _i17.PageRouteInfo<FullPhotoRouteArgs> {
  FullPhotoRoute({
    required String imageUrl,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          FullPhotoRoute.name,
          args: FullPhotoRouteArgs(
            imageUrl: imageUrl,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FullPhotoRoute';

  static const _i17.PageInfo<FullPhotoRouteArgs> page =
      _i17.PageInfo<FullPhotoRouteArgs>(name);
}

class FullPhotoRouteArgs {
  const FullPhotoRouteArgs({
    required this.imageUrl,
    this.key,
  });

  final String imageUrl;

  final _i18.Key? key;

  @override
  String toString() {
    return 'FullPhotoRouteArgs{imageUrl: $imageUrl, key: $key}';
  }
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MainPage]
class MainRoute extends _i17.PageRouteInfo<void> {
  const MainRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.OrderHistoryPage]
class OrderHistoryRoute extends _i17.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i17.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.PersonalInformationPage]
class PersonalInformationRoute
    extends _i17.PageRouteInfo<PersonalInformationRouteArgs> {
  PersonalInformationRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          PersonalInformationRoute.name,
          args: PersonalInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PersonalInformationRoute';

  static const _i17.PageInfo<PersonalInformationRouteArgs> page =
      _i17.PageInfo<PersonalInformationRouteArgs>(name);
}

class PersonalInformationRouteArgs {
  const PersonalInformationRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'PersonalInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.ProductPage]
class ProductRoute extends _i17.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required _i20.Product product,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const _i17.PageInfo<ProductRouteArgs> page =
      _i17.PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    required this.product,
    this.key,
  });

  final _i20.Product product;

  final _i18.Key? key;

  @override
  String toString() {
    return 'ProductRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i15.SignupPage]
class SignupRoute extends _i17.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i17.PageInfo<SignupRouteArgs> page =
      _i17.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.WelcomePage]
class WelcomeRoute extends _i17.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          WelcomeRoute.name,
          args: WelcomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i17.PageInfo<WelcomeRouteArgs> page =
      _i17.PageInfo<WelcomeRouteArgs>(name);
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}
