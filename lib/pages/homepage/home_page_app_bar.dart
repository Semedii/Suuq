import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/string_utilities.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    required this.numberItemsInCart,
    super.key,
  });
  final int numberItemsInCart;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.edgeInsetsT40,
      child: Container(
        padding: AppStyles.edgeInsets4,
        color: AppColors.lightestGrey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildSearchField(context),
            ),
            _buildCartButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton(BuildContext context) => IconButton(
      onPressed: () =>AutoRouter.of(context).push(const CartRoute()),
      icon:  Stack(
        alignment: Alignment.topRight,
        children: [
         const Icon(
            Icons.shopping_cart_rounded,
            size: 32,
          ),
          Badge(label: Text(numberItemsInCart.toString()), backgroundColor: AppColors.green,),
        ],
      ));

  TextField _buildSearchField(BuildContext context) {
     AppLocalizations localizations = AppLocalizations.of(context)!;
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightestGrey,
        hintText: localizations.comingSoon+StringUtilities.threeDots,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: AppColors.lightestGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.lightestGrey),
        ),
      ),
    );
  }
}
