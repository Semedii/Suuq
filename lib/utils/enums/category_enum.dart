import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Category {
  clothes(name: "clothes", imageUrl: "assets/image/tshirt.jpg"),
  shoes(name: "shoes", imageUrl: "assets/image/shoe.jpg"),
  homeAccessories(
    name: "home accessories",
    imageUrl: "assets/image/hanger.jpg",
  ),
  electronics(name: "electronics", imageUrl: "assets/image/tshirt.jpg"),
  gymAccessories(name: "gym accessories", imageUrl: "assets/image/tshirt.jpg"),
  kitchenAccessories(
    name: "kitchen accessories",
    imageUrl: "assets/image/tshirt.jpg",
  ),
  cosmetics(name: "cosmetics", imageUrl: "assets/image/tshirt.jpg"),
  others(name: "others", imageUrl: "assets/image/tshirt.jpg");

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
