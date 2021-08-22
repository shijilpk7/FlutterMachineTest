import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Restaurant {
  late String _restaurantId;
  late String _restaurantName;
  late String _restaurantImage;
  late String _tableId;
  late String _tableName;
  late String _branchName;
  late String _nexturl;
  late List<TableMenuList> _tableMenuList;

  Restaurant(
      {required String restaurantId,
      required String restaurantName,
      required String restaurantImage,
      required String tableId,
      required String tableName,
      required String branchName,
      required String nexturl,
      required List<TableMenuList> tableMenuList}) {
    this._restaurantId = restaurantId;
    this._restaurantName = restaurantName;
    this._restaurantImage = restaurantImage;
    this._tableId = tableId;
    this._tableName = tableName;
    this._branchName = branchName;
    this._nexturl = nexturl;
    this._tableMenuList = tableMenuList;
  }

  String get restaurantId => _restaurantId;
  set restaurantId(String restaurantId) => _restaurantId = restaurantId;
  String get restaurantName => _restaurantName;
  set restaurantName(String restaurantName) => _restaurantName = restaurantName;
  String get restaurantImage => _restaurantImage;
  set restaurantImage(String restaurantImage) =>
      _restaurantImage = restaurantImage;
  String get tableId => _tableId;
  set tableId(String tableId) => _tableId = tableId;
  String get tableName => _tableName;
  set tableName(String tableName) => _tableName = tableName;
  String get branchName => _branchName;
  set branchName(String branchName) => _branchName = branchName;
  String get nexturl => _nexturl;
  set nexturl(String nexturl) => _nexturl = nexturl;
  List<TableMenuList> get tableMenuList => _tableMenuList;
  set tableMenuList(List<TableMenuList> tableMenuList) =>
      _tableMenuList = tableMenuList;

  Restaurant.fromJson(Map<String, dynamic> json) {
    _restaurantId = json['restaurant_id'];
    _restaurantName = json['restaurant_name'];
    _restaurantImage = json['restaurant_image'];
    _tableId = json['table_id'];
    _tableName = json['table_name'];
    _branchName = json['branch_name'];
    _nexturl = json['nexturl'];
    if (json['table_menu_list'] != null) {
      // ignore: deprecated_member_use
      _tableMenuList = [];
      json['table_menu_list'].forEach((v) {
        _tableMenuList.add(new TableMenuList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this._restaurantId;
    data['restaurant_name'] = this._restaurantName;
    data['restaurant_image'] = this._restaurantImage;
    data['table_id'] = this._tableId;
    data['table_name'] = this._tableName;
    data['branch_name'] = this._branchName;
    data['nexturl'] = this._nexturl;
    if (this._tableMenuList != null) {
      data['table_menu_list'] =
          this._tableMenuList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableMenuList {
  late String _menuCategory;
  late String _menuCategoryId;
  late String _menuCategoryImage;
  late String _nexturl;
  late List<CategoryDishes> _categoryDishes;

  TableMenuList(
      {required String menuCategory,
      required String menuCategoryId,
      required String menuCategoryImage,
      required String nexturl,
      required List<CategoryDishes> categoryDishes}) {
    this._menuCategory = menuCategory;
    this._menuCategoryId = menuCategoryId;
    this._menuCategoryImage = menuCategoryImage;
    this._nexturl = nexturl;
    this._categoryDishes = categoryDishes;
  }

  String get menuCategory => _menuCategory;
  set menuCategory(String menuCategory) => _menuCategory = menuCategory;
  String get menuCategoryId => _menuCategoryId;
  set menuCategoryId(String menuCategoryId) => _menuCategoryId = menuCategoryId;
  String get menuCategoryImage => _menuCategoryImage;
  set menuCategoryImage(String menuCategoryImage) =>
      _menuCategoryImage = menuCategoryImage;
  String get nexturl => _nexturl;
  set nexturl(String nexturl) => _nexturl = nexturl;
  List<CategoryDishes> get categoryDishes => _categoryDishes;
  set categoryDishes(List<CategoryDishes> categoryDishes) =>
      _categoryDishes = categoryDishes;

  TableMenuList.fromJson(Map<String, dynamic> json) {
    _menuCategory = json['menu_category'];
    _menuCategoryId = json['menu_category_id'];
    _menuCategoryImage = json['menu_category_image'];
    _nexturl = json['nexturl'];
    if (json['category_dishes'] != null) {
      _categoryDishes = [];
      json['category_dishes'].forEach((v) {
        _categoryDishes.add(new CategoryDishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_category'] = this._menuCategory;
    data['menu_category_id'] = this._menuCategoryId;
    data['menu_category_image'] = this._menuCategoryImage;
    data['nexturl'] = this._nexturl;
    if (this._categoryDishes != null) {
      data['category_dishes'] =
          this._categoryDishes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDishes {
  late String _dishId;
  late String _dishName;
  late double _dishPrice;
  late String _dishImage;
  late String _dishCurrency;
  late double _dishCalories;
  late String _dishDescription;
  late bool _dishAvailability;
  late int _dishType;
  late String _nexturl;
  late List<AddonCat> _addonCat;

  CategoryDishes(
      {required String dishId,
      required String dishName,
      required double dishPrice,
      required String dishImage,
      required String dishCurrency,
      required double dishCalories,
      required String dishDescription,
      required bool dishAvailability,
      required int dishType,
      required String nexturl,
      required List<AddonCat> addonCat}) {
    this._dishId = dishId;
    this._dishName = dishName;
    this._dishPrice = dishPrice;
    this._dishImage = dishImage;
    this._dishCurrency = dishCurrency;
    this._dishCalories = dishCalories;
    this._dishDescription = dishDescription;
    this._dishAvailability = dishAvailability;
    this._dishType = dishType;
    this._nexturl = nexturl;
    this._addonCat = addonCat;
  }

  String get dishId => _dishId;
  set dishId(String dishId) => _dishId = dishId;
  String get dishName => _dishName;
  set dishName(String dishName) => _dishName = dishName;
  double get dishPrice => _dishPrice;
  set dishPrice(double dishPrice) => _dishPrice = dishPrice;
  String get dishImage => _dishImage;
  set dishImage(String dishImage) => _dishImage = dishImage;
  String get dishCurrency => _dishCurrency;
  set dishCurrency(String dishCurrency) => _dishCurrency = dishCurrency;
  double get dishCalories => _dishCalories;
  set dishCalories(double dishCalories) => _dishCalories = dishCalories;
  String get dishDescription => _dishDescription;
  set dishDescription(String dishDescription) =>
      _dishDescription = dishDescription;
  bool get dishAvailability => _dishAvailability;
  set dishAvailability(bool dishAvailability) =>
      _dishAvailability = dishAvailability;
  int get dishType => _dishType;
  set dishType(int dishType) => _dishType = dishType;
  String get nexturl => _nexturl;
  set nexturl(String nexturl) => _nexturl = nexturl;
  List<AddonCat> get addonCat => _addonCat;
  set addonCat(List<AddonCat> addonCat) => _addonCat = addonCat;

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    _dishId = json['dish_id'];
    _dishName = json['dish_name'];
    _dishPrice = json['dish_price'];
    _dishImage = json['dish_image'];
    _dishCurrency = json['dish_currency'];
    _dishCalories = json['dish_calories'];
    _dishDescription = json['dish_description'];
    _dishAvailability = json['dish_Availability'];
    _dishType = json['dish_Type'];
    _nexturl = json['nexturl'];
    if (json['addonCat'] != null) {
      _addonCat = [];
      json['addonCat'].forEach((v) {
        _addonCat.add(new AddonCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this._dishId;
    data['dish_name'] = this._dishName;
    data['dish_price'] = this._dishPrice;
    data['dish_image'] = this._dishImage;
    data['dish_currency'] = this._dishCurrency;
    data['dish_calories'] = this._dishCalories;
    data['dish_description'] = this._dishDescription;
    data['dish_Availability'] = this._dishAvailability;
    data['dish_Type'] = this._dishType;
    data['nexturl'] = this._nexturl;
    if (this._addonCat != null) {
      data['addonCat'] = this._addonCat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonCat {
  late String _addonCategory;
  late String _addonCategoryId;
  late int _addonSelection;
  late String _nexturl;
  late List<Addons> _addons;

  AddonCat(
      {required String addonCategory,
      required String addonCategoryId,
      required int addonSelection,
      required String nexturl,
      required List<Addons> addons}) {
    this._addonCategory = addonCategory;
    this._addonCategoryId = addonCategoryId;
    this._addonSelection = addonSelection;
    this._nexturl = nexturl;
    this._addons = addons;
  }

  String get addonCategory => _addonCategory;
  set addonCategory(String addonCategory) => _addonCategory = addonCategory;
  String get addonCategoryId => _addonCategoryId;
  set addonCategoryId(String addonCategoryId) =>
      _addonCategoryId = addonCategoryId;
  int get addonSelection => _addonSelection;
  set addonSelection(int addonSelection) => _addonSelection = addonSelection;
  String get nexturl => _nexturl;
  set nexturl(String nexturl) => _nexturl = nexturl;
  List<Addons> get addons => _addons;
  set addons(List<Addons> addons) => _addons = addons;

  AddonCat.fromJson(Map<String, dynamic> json) {
    _addonCategory = json['addon_category'];
    _addonCategoryId = json['addon_category_id'];
    _addonSelection = json['addon_selection'];
    _nexturl = json['nexturl'];
    if (json['addons'] != null) {
      // ignore: deprecated_member_use
      _addons = [];
      json['addons'].forEach((v) {
        _addons.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_category'] = this._addonCategory;
    data['addon_category_id'] = this._addonCategoryId;
    data['addon_selection'] = this._addonSelection;
    data['nexturl'] = this._nexturl;
    if (this._addons != null) {
      data['addons'] = this._addons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addons {
  late String _dishId;
  late String _dishName;
  late double _dishPrice;
  late String _dishImage;
  late String _dishCurrency;
  late double _dishCalories;
  late String _dishDescription;
  late bool _dishAvailability;
  late int _dishType;

  Addons(
      {required String dishId,
      required String dishName,
      required double dishPrice,
      required String dishImage,
      required String dishCurrency,
      required double dishCalories,
      required String dishDescription,
      required bool dishAvailability,
      required int dishType}) {
    this._dishId = dishId;
    this._dishName = dishName;
    this._dishPrice = dishPrice;
    this._dishImage = dishImage;
    this._dishCurrency = dishCurrency;
    this._dishCalories = dishCalories;
    this._dishDescription = dishDescription;
    this._dishAvailability = dishAvailability;
    this._dishType = dishType;
  }

  String get dishId => _dishId;
  set dishId(String dishId) => _dishId = dishId;
  String get dishName => _dishName;
  set dishName(String dishName) => _dishName = dishName;
  double get dishPrice => _dishPrice;
  set dishPrice(double dishPrice) => _dishPrice = dishPrice;
  String get dishImage => _dishImage;
  set dishImage(String dishImage) => _dishImage = dishImage;
  String get dishCurrency => _dishCurrency;
  set dishCurrency(String dishCurrency) => _dishCurrency = dishCurrency;
  double get dishCalories => _dishCalories;
  set dishCalories(double dishCalories) => _dishCalories = dishCalories;
  String get dishDescription => _dishDescription;
  set dishDescription(String dishDescription) =>
      _dishDescription = dishDescription;
  bool get dishAvailability => _dishAvailability;
  set dishAvailability(bool dishAvailability) =>
      _dishAvailability = dishAvailability;
  int get dishType => _dishType;
  set dishType(int dishType) => _dishType = dishType;

  Addons.fromJson(Map<String, dynamic> json) {
    _dishId = json['dish_id'];
    _dishName = json['dish_name'];
    _dishPrice = json['dish_price'];
    _dishImage = json['dish_image'];
    _dishCurrency = json['dish_currency'];
    _dishCalories = json['dish_calories'];
    _dishDescription = json['dish_description'];
    _dishAvailability = json['dish_Availability'];
    _dishType = json['dish_Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this._dishId;
    data['dish_name'] = this._dishName;
    data['dish_price'] = this._dishPrice;
    data['dish_image'] = this._dishImage;
    data['dish_currency'] = this._dishCurrency;
    data['dish_calories'] = this._dishCalories;
    data['dish_description'] = this._dishDescription;
    data['dish_Availability'] = this._dishAvailability;
    data['dish_Type'] = this._dishType;
    return data;
  }
}

class Order {
  late String _restaurantId;
  late String _dishId;
  late int _dishCount = 0;
  late String _menuCategoryid;

  Order(
      {String? restaurantId,
      String? dishId,
      int? dishCount,
      String? menucategoryId}) {
    this._dishCount = dishCount!;
    this._dishId = dishId!;
    this._restaurantId = restaurantId!;
    this._menuCategoryid = menucategoryId!;
  }

  String get restaurantId => _restaurantId;
  set restaurantId(String restaurantId) => _restaurantId = restaurantId;
  String get dishId => _dishId;
  set dishId(String dishId) => _dishId = dishId;
  int get dishCount => _dishCount;
  set dishCount(int dishCount) => _dishCount = dishCount;

  String get menucategoryId => _menuCategoryid;
  set menucategoryId(String menucategoryId) => _menuCategoryid = menucategoryId;
}
