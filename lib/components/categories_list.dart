import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }

  Column _buildCategoryItem() {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          child: Image.asset("assets/images/boy.png"),
        ),
        Text(
          "Women",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
