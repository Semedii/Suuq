import 'package:flutter/material.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final Product product = Product(
      sellerName: "Shaal Online Market",
      imageUrl: ["assets/images/boy.png"],
      description:
          "Surwaal fiican oo cad Surwaal Surwaal Surwaal  fiican oo cad Surwaal fiican oo cad",
      price: 2,
      category: Category.clothes);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.edgeInsetsH16V24,
      child: Column(
        children: [
          Card(
              child: Row(
            children: [
              _buildImage(),
              _buildInfo(),
            ],
          ))
        ],
      ),
    );
  }

  Image _buildImage() {
    return Image.asset(
      product.imageUrl.first ?? "",
      height: 100,
      width: 150,
    );
  }

  Expanded _buildInfo() {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSellerName(),
            _buildDescription(),
            _buildPrice(),
            _buildDateAndStatus()
          ],
        ),
      ),
    );
  }

  Text _buildSellerName() {
    return Text(
      product.sellerName,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text _buildDescription() => Text(
        product.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Text _buildPrice() {
    return Text(
      "${product.price.toString()} \$",
      style: const TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row _buildDateAndStatus() {
    return const Row(
      children: [
        Text("07/05/2023"),
        Spacer(),
        Text(
          "Pending",
          style: TextStyle(color: Color.fromARGB(255, 101, 92, 7)),
        )
      ],
    );
  }
}
