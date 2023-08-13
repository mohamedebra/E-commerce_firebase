import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(productCollection).add({
      productName: product.pName,
      productDescription: product.pDescription,
      productLocation: product.pLocation,
      productCategory: product.pCategory,
      productPrice: product.pPrice
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(productCollection).snapshots();
  }




  deleteProduct(documentId) {
    _firestore.collection(productCollection).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(productCollection)
        .doc(documentId)
        .update(data);
  }

}