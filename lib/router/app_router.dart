import 'package:auto_route/auto_route.dart';
import 'package:suuq/router/app_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends $AppRouter {

 @override
 List<AutoRoute> get routes => [
  AutoRoute(page: AuthenticationWrapper.page, initial: true),
  AutoRoute(page: MainRoute.page),
  AutoRoute(page: HomeRoute.page),
   AutoRoute(page: WelcomeRoute.page),
   AutoRoute(page: LoginRoute.page),
   AutoRoute(page: SignupRoute.page),
   AutoRoute(page: ProductRoute.page),
   AutoRoute(page: CheckOutRoute.page),
   AutoRoute(page: CartRoute.page),
   AutoRoute(page: ConfirmationRoute.page),
   AutoRoute(page: ShowAllRoute.page),
   AutoRoute(page: OrderHistoryRoute.page),
   AutoRoute(page: PersonalInformationRoute.page),
   AutoRoute(page: ChangePasswordRoute.page),
   AutoRoute(page: ChangeLanguageRoute.page)
 ];
}