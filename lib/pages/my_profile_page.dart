import 'package:flutter/material.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/app_colors.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.lightestGrey,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildHeader(context),
                  _buildMenuList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .4,
      decoration: _buildHeaderDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildAvatar(), _buildusername()],
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

  Text _buildusername() {
    return const Text(
      "Abdisamad Ibrahim",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  Positioned _buildMenuList(
    BuildContext context,
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
                  onTap: AuthService().logout,
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
