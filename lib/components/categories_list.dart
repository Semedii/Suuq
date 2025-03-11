import 'package:flutter/material.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Category.values.length,
            itemBuilder: (context, index) {
              final category = Category.values[index];
              return _buildCategoryItem(category.name, category.imageUrl);
            }));
  }

  SizedBox _buildCategoryItem(String name, String imageUrl) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
