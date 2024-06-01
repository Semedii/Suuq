class CategorySearchFilters {
  final bool isClothes;
  final bool isShoes;
  final bool isHomeAccessories;
  final bool isElectronics;
  final bool isGymAccessories;
  final bool isKitchenAccessories;
  final bool isCosmetics;
  final bool isOthers;

  CategorySearchFilters({
    this.isClothes = false,
    this.isShoes = false,
    this.isHomeAccessories = false,
    this.isElectronics = false,
    this.isGymAccessories = false,
    this.isKitchenAccessories = false,
    this.isCosmetics = false,
    this.isOthers = false,
  });

  CategorySearchFilters copyWith({
    bool? isClothes,
    bool? isShoes,
    bool? isHomeAccessories,
    bool? isElectronics,
    bool? isGymAccessories,
    bool? isKitchenAccessories,
    bool? isCosmetics,
    bool? isOthers,
  }) {
    return CategorySearchFilters(
      isClothes: isClothes ?? this.isClothes,
      isShoes: isShoes ?? this.isShoes,
      isHomeAccessories: isHomeAccessories ?? this.isHomeAccessories,
      isElectronics: isElectronics ?? this.isElectronics,
      isGymAccessories: isGymAccessories ?? this.isGymAccessories,
      isKitchenAccessories: isKitchenAccessories ?? this.isKitchenAccessories,
      isCosmetics: isCosmetics ?? this.isCosmetics,
      isOthers: isOthers ?? this.isOthers,
    );
  }

  bool isFilterActive(String key) {
    final filters = {
      'clothes': isClothes,
      'shoes': isShoes,
      'home accessories': isHomeAccessories,
      'electronics': isElectronics,
      'gym accessories': isGymAccessories,
      'kitchen accessories': isKitchenAccessories,
      'cosmetics': isCosmetics,
      'others': isOthers,
    };

    return filters[key] ?? false;
  }

  Map<String, bool> getActiveFilters() {
    return {
      'clothes': isClothes,
      'shoes': isShoes,
      'home accessories': isHomeAccessories,
      'electronics': isElectronics,
      'gym accessories': isGymAccessories,
      'kitchen accessories': isKitchenAccessories,
      'cosmetics': isCosmetics,
      'others': isOthers,
    }..removeWhere((key, value) => value == false);
  }
  bool isAnyFilterActive() {
    return isClothes ||
           isShoes ||
           isHomeAccessories ||
           isElectronics ||
           isGymAccessories ||
           isKitchenAccessories ||
           isCosmetics ||
           isOthers;
  }
}
