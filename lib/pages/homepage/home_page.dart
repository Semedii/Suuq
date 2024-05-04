import 'package:flutter/material.dart';

import 'package:suuq/components/item_card.dart';
import 'package:suuq/models/item.dart';
import 'package:suuq/pages/homepage/home_page_app_bar.dart';
import 'package:suuq/utils/app_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: HomePageAppBar(),
        ),
        body: Padding(
          padding: AppStyles.edgeInsets4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildNiche("Garamaan", tShirts),
                _buildNiche("Kabo", shoes),
                _buildNiche("Alaabta guriga", homeAccessories, expand: false)
              ],
            ),
          ),
        ));
  }

  SizedBox _buildNiche(String nicheName, List<Item> items, {bool expand = true}) {
   if(expand) {
     items = items
        .expand((element) => [element, element, element, element])
        .toList();
   }
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nicheName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Show All",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemCard(
                  imageUrl: item.imageUrl!,
                  sellerName: item.sellerName,
                  description: item.description,
                  price: item.price,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Item> tShirts = [
  Item(
    sellerName: "Shaal Online",
    description: "Garan/Garamad oversize ah",
    price: 12,
    imageUrl: "assets/images/tshirt.jpg",
  ),
];

List<Item> shoes = [
  Item(
    sellerName: "Semedy",
    description: "kabo shark triko oo madaw",
    price: 12,
    imageUrl: "assets/images/shoe.jpg",
  ),
];

List<Item> homeAccessories = [
  Item(
    sellerName: "Shaal Online",
    description: "Container ama box-ka cuntada lagu kaydiyo",
    price: 5,
    imageUrl: "assets/images/container.jpg",
  ),
   Item(
    sellerName: "Suuq Online",
    description: "Maqli aan ku dhegeyn",
    price: 15,
    imageUrl: "assets/images/pan.jpg",
  ),
   Item(
    sellerName: "WaxWalba Online",
    description: "Hanger-ka dharka la sudho",
    price: 6,
    imageUrl: "assets/images/hanger.jpg",
  ),
];
