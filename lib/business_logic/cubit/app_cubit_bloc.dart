import 'dart:async';
import 'dart:io';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/data/web_services/character_api.dart';
import 'package:api/presentation/screens/admin/addProducts.dart';
import 'package:api/presentation/screens/admin/manageProduct.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/screens/user/home_screen.dart';
import 'package:api/presentation/screens/user/productInfo.dart';
import 'package:api/presentation/screens/user/reports.dart';
import 'package:api/presentation/screens/user/Account.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

part 'app_cubit_state.dart';

class BuyCubit extends Cubit<BuyState> {
  BuyCubit() : super(BuyInitial());

  static BuyCubit get(context) => BlocProvider.of(context);
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isColor = false;
  List<Product> products = [];
  int currentIndex = 0;
  bool keepMeLoggedIn = false;
  File? proFileimage;
  var picker = ImagePicker();

  List screens = [
    Home_Screen(),
    Reports(),
    SignOut(),
  ];


  void changeBottonNav(index) {
    currentIndex = index;
    emit(ChangeBottonNav());
  }

  changeCheckbox(value){
    keepMeLoggedIn = !value;
    emit(ChangeCheckbox());
  }

  signUp({required email, required password}) async {
    emit(BuyLoaded());
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(BuyScsuss());
    }).catchError((error) {
      emit(BuyError(error.toString()));
    });
  }

  signIn({required email, required password}) async {
    emit(BuyLoadedSginIn());
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(BuyScsussSginIn());
    }).catchError((error) {
      emit(BuyErrorSginIn(error.toString()));
    });
  }

  changeLoading(bool value) {
    isLoading = value;
    emit(BuyIsLoading());
  }

  changeColor(bool value) {
    isColor = value;
    emit(BuyIsColor());
  }

  addProduct(Product product) {
    _firestore.collection(productCollection).add({
      productName: product.pName,
      productPrice: product.pPrice,
      productCategory: product.pCategory,
      productDescription: product.pDescription,
      productLocation: product.pLocation
    });
    emit(BuyAddProduct());
  }
  addProductItems(Product product,_quantity){
    products.add(product);
    product.pQuantity = _quantity;
    emit(AddProductItmes());
  }

  Future<List<Product>> loadProduct() async {
    emit(LoadProdact());

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await for (var snapshot
        in _firestore.collection(productCollection).snapshots()) {
      for (var doc in snapshot.docs) {
        var data = doc.data();
        products.add(Product(
            pPrice: data[productPrice],
            pLocation: data[productLocation],
            pDescription: data[productDescription],
            pCategory: data[productCategory],
            pName: data[productName],
            pid: doc.id));
      }
    }
    emit(LoadProdactSucsess());

    return products;
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(productCollection).snapshots();
  }


  Stream<QuerySnapshot> loadOrderDetails(id){
    return _firestore.collection(kOrders).doc(id).collection(kOrderDetails).snapshots();
  }

  deleteProduct(docId) async {
    await _firestore.collection(productCollection).doc(docId).delete();
    emit(DeleteProduct());
  }

  editProduct(data, docId) async {
    await _firestore.collection(productCollection).doc(docId).update(data);
  }
  deleteProductItems(product) {
    products.remove(product);
    emit(DeleteProductItems());

  }

  showCustomMenu(details,context,products) {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 =
        MediaQuery.of(context).size.width - dx;
    double dy2 =
        MediaQuery.of(context).size.width - dy;
    showMenu(
        context: context,
        position:
        RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              deleteProduct(products);
              Navigator.pushNamed(context, ProductInfo.id,arguments:products);
              emit(EditMenuItems());
            },
            child: Text('Edit'),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              deleteProduct(products);
              emit(DeleteProducts());
            },
            child: Text('Delete'),
          )
        ]);

  }

  storeOrders(data,List<Product> product){
   var docRef =  _firestore.collection(kOrders).doc();
   docRef.set(data);
   for(var product in products){
     docRef.collection(kOrderDetails).doc().set({
       productName : product.pName,
       productPrice : product.pPrice,
       kProductQuantity : product.pQuantity,
       productLocation : product.pLocation,

     });
   }
   emit(BuyAddProductOrder());

  }
  storeProduct(){
    var docRef =  _firestore.collection(productCollection).doc();
    for(var product in products){
      docRef.set({
        productName : product.pName,
        productPrice : product.pPrice,
        kProductQuantity : product.pQuantity,
        productLocation : product.pLocation,

      });
    }
    emit(AddProductOrder());

  }

  Stream<QuerySnapshot> loadOrders(){
    return _firestore.collection(kOrders).snapshots();
  }//.getImage(source: ImageSource.gallery)
  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {

      proFileimage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppImageSucsessState());
    }else
    {
      print('No image selected');
      emit(AppImageErorrState());

    }
  }

}
