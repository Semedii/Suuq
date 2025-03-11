import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Category {
  homeAccessories(
    name: "Home Accessories",
    imageUrl: "assets/images/hanger.jpg",
  ),
  kitchenAccessories(
    name: "Kitchen Accessories",
    imageUrl: "assets/images/tshirt.jpg",
  ),
  gymAccessories(name: "Gym Accessories", imageUrl: "assets/images/tshirt.jpg"),
  electronics(name: "Electronics", imageUrl: "assets/images/tshirt.jpg"),
  shoes(name: "Shoes", imageUrl: "assets/images/shoe.jpg"),
  clothes(name: "Clothes", imageUrl: "assets/images/tshirt.jpg"),

  cosmetics(name: "Cosmetics", imageUrl: "assets/images/tshirt.jpg"),
  others(name: "Others", imageUrl: "assets/images/tshirt.jpg");

  final String name;
  final String imageUrl;

  const Category({required this.name, required this.imageUrl});
}

Category getCategoryFromString(String categoryString) {
  for (var category in Category.values) {
    if (category.name.toLowerCase() == categoryString.toLowerCase()) {
      return category;
    }
  }
  throw ArgumentError('Unknown category: $categoryString');
}

String getCategoryTranslations(
    Category category, AppLocalizations localizations) {
  switch (category) {
    case Category.clothes:
      return localizations.clothes;
    case Category.shoes:
      return localizations.shoes;
    case Category.homeAccessories:
      return localizations.homeAccessories;
    case Category.electronics:
      return localizations.electronics;
    case Category.gymAccessories:
      return localizations.gymAccessories;
    case Category.cosmetics:
      return localizations.cosmetics;
    case Category.others:
      return 'others';
    case Category.kitchenAccessories:
      return localizations.kitchenAccessories;
  }
}
