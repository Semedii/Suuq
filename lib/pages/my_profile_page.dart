import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/login/login_notifier.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/string_utilities.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var loginSuccessSate =
    //     ref.read(loginInNotifierProvider) as LoginSuccessState;
    return Scaffold(
      body: Container(
        color: AppColors.lightestGrey,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildHeader(context,"s"),
                  _buildMenuList(context, ref),
                ],
              ),
            ),
          ],
        ),
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
    return Positioned(
        top: MediaQuery.of(context).size.height * .42,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _getMenu(Icons.person, "Personal Information"),
                _getMenu(Icons.lock, "Change Password"),
                _getMenu(Icons.history, "Order History"),
                _getMenu(Icons.favorite, "Favorites"),
                _getMenu(Icons.person, "About Suuq"),
                _getMenu(
                  Icons.logout_outlined,
                  "Logout",
                  onTap: ref.read(loginInNotifierProvider.notifier).handleLogout,
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
