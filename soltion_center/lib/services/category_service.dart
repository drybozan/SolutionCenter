import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:soltion_center/models/category_model.dart';

class CategoryService {
  // create instance of FirebaseFirestore
  final db = FirebaseFirestore.instance;


// get all categories
  Future<List<CategoryModel>?> getCategories() async {
    try {
      var querySnapshot = await db.collection("categories").get();

      List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        // Veritabanından her bir belgeyi CategoryModel'e dönüştürüyoruz
        return CategoryModel.fromJson(doc.data());
      }).toList();

      return categories;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  //get category by id
  Future<CategoryModel?> getCategory(String id) async {
    try {
      var data = await db.collection("categories").doc(id).get();

      return CategoryModel.fromJson(data.data()!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  //get category by id
  Future<List<CategoryModel>?> getCategoryList(List<String> idList) async {
    List<CategoryModel>? categories = [];

    try {
      for(String id in idList){
        var data = await db.collection("categories").doc(id).get();
        categories.add(CategoryModel.fromJson(data.data()!));
      }
      return categories;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

// add category to db ,Input -> (List[CategoryModel] categories)
Future<void> addCategory(CategoryModel category) async {
    final categoryRef = db.collection("categories").doc(category.categoryId);
    final categorySnapshot = await categoryRef.get();

    if (categorySnapshot.exists) {
      // Kategori zaten var, uyarı ver veya isterseniz üzerine yazma yapma.
      print("Uyarı: ${category.categoryName} adlı kategori zaten mevcut.");
    } else {
      // Kategori yok, yeni bir kayıt olarak ekleyelim.
      await categoryRef.set(category.toJson());
    }

}


 

// delete category 
  Future<void> deleteCategory(String categoryId)async {  

  final categoryDocRef = db.collection("categories").doc(categoryId);
  final categorySnapshot = await categoryDocRef.get();

  if (categorySnapshot.exists) {
    // Eğer kategori varsa, silme işlemini gerçekleştir
    await categoryDocRef.delete();
    print("Kategori başarıyla silindi");
  } else {
    // Eğer kategori yoksa, hata mesajı ver
    print("Silinmek istenen kategori bulunamadı");
  }
  }

}
