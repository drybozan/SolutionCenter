import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/services/auth_service.dart';

import '../services/category_service.dart';

class CategoryController with ChangeNotifier {


  final CategoryService _categoryService = CategoryService();
  final AuthService userServices = AuthService();

 // List<CategoryModel> categories = [];
  List<CategoryModel> _allCategories = [];

  List<CategoryModel> _userCategory = [];

  List<CategoryModel> _searchedCategories = [];


  List<CategoryModel> get searchedCategories => _searchedCategories;

  set searchedCategories(List<CategoryModel> value) {
    _searchedCategories = value;
    notifyListeners();
  }

  var categoryNameController = TextEditingController();
  CategoryModel? categoryModel;

  bool _isLogin = true;
  bool _isFilled = false;

  bool get getIsLogin => _isLogin;

  bool get getIsFilled => _isFilled;

  set setIsFilled(bool condition) {
    _isFilled = condition;
  }

  setIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

// boş veri kontrolü sağlanır aksi takdirde kullanıcıya uyarı verilir.
  void isNotBlank() {
    if (!_isLogin) {
      if (categoryNameController.text.isEmpty) {
        _isFilled = false;
        //TODO send back that the fields is empty
        notifyListeners();
      } else {
        _isFilled = true;
        notifyListeners();
      }
    } else {
      //TODO add the login error
    }
  }

// get all category
  Future<List<CategoryModel>> getAllCategories() async {
    if (_allCategories.isEmpty ){
      _allCategories = (await _categoryService.getCategories())!;
    print("service all Categories");
    _allCategories.forEach((element) {
      print(element.categoryName);
    });
    return _allCategories;
    }else {
      print("_allCategories");
      _allCategories.forEach((element) {
        print(element.categoryName);
      });
      return _allCategories;
    }

  }


  deleteCategoryFromUser(CategoryModel category) async {
    _userCategory = await getCategoryOfUser();

    for (var cat in _userCategory) {
      if (cat.categoryId!.compareTo(category.categoryId!) == 0) {
        userServices.deleteCategoryToUser(category);
        _userCategory.remove(category);
        notifyListeners();
      }
    }

  }

  // get category by id
  Future<CategoryModel?> getCategoryById(String categoryId) async {
    try {
      CategoryModel? category = await _categoryService.getCategory(categoryId);
      if (category != null) {
        // Kategori bulundu
        print('category name: ${category.categoryName}');
        return category;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return null;
  }

  // get category by id
  Future<List<CategoryModel>?> getListOfCategoryById(
      List<String> categoriesID) async {
    try {
      List<CategoryModel>? categories = await _categoryService.getCategoryList(
          categoriesID);
      if (categories != null) {
        // Kategori bulundu
        categories.forEach((category) {
          print('Kategori adı: ${category.categoryName}');
        });
        return categories;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return null;
  }

  // add category
  Future<void> addCategory(CategoryModel category) async {
    print("addCategory");
    List<CategoryModel>? list = await _categoryService.getCategories();
    if (!list!.contains(category)) {
      _categoryService.addCategory(category);
      _allCategories.add(category);
      _userCategory.add(category);
    }
    notifyListeners();
  }

  addCategoryToUser(CategoryModel category) async {
    _userCategory = await getCategoryOfUser();
    if (_userCategory.contains(category) == false) {
      _userCategory.add(category);
      userServices.addCategoryToUser(category);
      notifyListeners();
    }
  }

Future<List<CategoryModel>> getCategoryOfUser() async {
  return await userServices.getUserCategory();
}

  // Kategori silme işlemi
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _categoryService.deleteCategory(categoryId);
      // Kategoriyi sildikten sonra kategorileri tekrar çek ve güncelle
      await getAllCategories();
    } catch (e) {
      print(e);
    }
  }
}
