import 'package:chopspick/app/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  saveProduct() async {
    await firestore.collection("products").add({
      'name': "Çikollatalı pasta",
      'categoryId': 3,
      'picture':
          "https://firebasestorage.googleapis.com/v0/b/chopspick-dca1e.appspot.com/o/products%2F212-2126060_chocolate-cake-hd-png-download.png.jpeg?alt=media&token=538876b0-fe53-491a-ba96-0bf3eac4e329",
      'star': "4.8",
      'price': 45,
      'description': "Çikolatalı pastayım ben"
    });
  }

  Future<List<ProductModel>> readProduct({int? categoryId}) async {
    List<ProductModel> productList = [];
    QuerySnapshot<Map<String, dynamic>> allProduct;

    if (categoryId == 0) {
      allProduct = await firestore.collection('products').limit(50).get();
      for (var element in allProduct.docs) {
        productList.add(ProductModel.fromMap(element.data()));
      }
      return productList;
    } else {
      var selectedProducts = await firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId).limit(50)
          .get();
      productList = [];
      for (var element in selectedProducts.docs) {
        productList.add(ProductModel.fromMap(element.data()));
      }
      return productList;
    }
  }
}
