import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/login/login_notifier.dart';
import 'package:suuq/notifiers/myProfile/account_notifier.dart';
import 'package:suuq/notifiers/myProfile/account_state.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/string_utilities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(accountNotifierProvider);
    return Scaffold(
      body: _mapStateToWidget(context, ref, profileState),
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    AccountState state,
  ) {
    if (state is AccountInitialState) {
      ref.read(accountNotifierProvider.notifier).initPage();
    } else if (state is AccountLoadedState) {
      return _buildProfilePageBody(context, state, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Container _buildProfilePageBody(
    BuildContext context,
    AccountLoadedState state,
    WidgetRef ref,
  ) {
    return Container(
      color: AppColors.lightestGrey,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildHeader(context, state.userName),
                _buildMenuList(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeader(BuildContext context, String? name) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .4,
      decoration: _buildHeaderDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildAvatar(), _buildusername(name)],
      ),
    );
  }

  CircleAvatar _buildAvatar() {
    return const CircleAvatar(
      backgroundImage: AssetImage("assets/images/boy.png"),
      radius: 50,
    );
  }

  BoxDecoration _buildHeaderDecoration() {
    return BoxDecoration(
      color: AppColors.lighterGrey,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),
    );
  }

  Text _buildusername(String? name) {
    return Text(
      name ?? StringUtilities.emptyString,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  Positioned _buildMenuList(
    BuildContext context,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Positioned(
        top: MediaQuery.of(context).size.height * .42,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _getMenu(Icons.person, localizations.personalInformation, onTap: ()=> AutoRouter.of(context).push(PersonalInformationRoute())),
                _getMenu(Icons.lock, localizations.changePassword),
                _getMenu(Icons.language, localizations.changeLanguage),
                _getMenu(Icons.history, localizations.orderHistory,
                    onTap: () =>
                        AutoRouter.of(context).push(const OrderHistoryRoute())),
                _getMenu(Icons.favorite, localizations.favorites),
                _getMenu(Icons.person, "About Suuq"),
                _getMenu(
                  Icons.logout_outlined,
                  localizations.logOut,
                  onTap:
                      ref.read(loginInNotifierProvider.notifier).handleLogout,
                ),
              ],
            ),
          ),
        ));
  }

  Card _getMenu(IconData leadingIcon, String title, {void Function()? onTap}) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon),
        title: Text(title),
      ),
    );
  }
}
