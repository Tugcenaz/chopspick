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

  Future<List<ProductModel>> readProduct() async {
    List<ProductModel> productList = [];
    QuerySnapshot<Map<String, dynamic>> allProduct =
        await firestore.collection('products').get();
    for (var element in allProduct.docs) {
      productList.add(ProductModel.fromMap(element.data()));
    }
    return productList;
  }
}
