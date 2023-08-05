class CategoryModel {
  String? categoryId;
  String? categoryName;



  CategoryModel({
    this.categoryId,
    required this.categoryName,
  });

   // Firebase Firestore'dan dökümanı okuyup Category nesnesine dönüştüren metot

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];

    
  }

  // Category nesnesini Firebase Firestore'a yazmak için kullanılacak metot

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;

    return data;
  }

  CategoryModel.demo();

  List<CategoryModel> getListOfCategories(){
    return [
      CategoryModel(
        categoryId: '1',
          categoryName: 'Software'
      ),
      CategoryModel(
          categoryId: '2',
          categoryName: 'UI/UX'
      ),
      CategoryModel(
          categoryId: '3',
          categoryName: 'AI'
      ),
      CategoryModel(
          categoryId: '4',
          categoryName: 'Computer Act'
      ),
      CategoryModel(
          categoryId: '5',
          categoryName: 'Analysis'
      ),
    ];
  }
}