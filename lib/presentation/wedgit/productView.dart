
import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/presentation/screens/user/productInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 List<Product> _products=[];



Widget ProductsView(String pCategory, List<Product> allProducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: .8,
    ),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfo.id,
              arguments: products[index]);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(products[index].pLocation),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          products[index].pName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${products[index].pPrice}')
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );
}


Widget jacketView() {
  return BlocConsumer<BuyCubit,BuyState>(
    listener: (context,state){},
    builder: (context,state){
      var cubit = BuyCubit.get(context);
      return StreamBuilder<QuerySnapshot>(
        stream: cubit.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {git init
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              var data = doc.get;
              products.add(Product(
                  pid: doc.id,
                  pPrice: data(productPrice),
                  pName: data(productName),
                  pDescription: data(productDescription),
                  pLocation: data(productLocation),
                  pCategory: data(productCategory)));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kJackets, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      );
    },
  );}

trouserVeiw() {
  return BlocConsumer<BuyCubit,BuyState>(
    listener: (context,state){},
    builder: (context,state){
      var cubit = BuyCubit.get(context);
      return StreamBuilder<QuerySnapshot>(
        stream: cubit.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              var data = doc.get;
              products.add(Product(
                  pid: doc.id,
                  pPrice: data(productPrice),
                  pName: data(productName),
                  pDescription: data(productDescription),
                  pLocation: data(productLocation),
                  pCategory: data(productCategory)));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kTrousers, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      );
    },
  );}

tShirtVeiw() {
  return BlocConsumer<BuyCubit,BuyState>(
    listener: (context,state){},
    builder: (context,state){
      var cubit = BuyCubit.get(context);
      return StreamBuilder<QuerySnapshot>(
        stream: cubit.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              var data = doc.get;
              products.add(Product(
                  pid: doc.id,
                  pPrice: data(productPrice),
                  pName: data(productName),
                  pDescription: data(productDescription),
                  pLocation: data(productLocation),
                  pCategory: data(productCategory)));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kTshirts, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      );
    },
  );}

shoesVeiw() {
  return BlocConsumer<BuyCubit,BuyState>(
    listener: (context,state){},
    builder: (context,state){
      var cubit = BuyCubit.get(context);
      return StreamBuilder<QuerySnapshot>(
        stream: cubit.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              var data = doc.get;
              products.add(Product(
                  pid: doc.id,
                  pPrice: data(productPrice),
                  pName: data(productName),
                  pDescription: data(productDescription),
                  pLocation: data(productLocation),
                  pCategory: data(productCategory)));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kShoes, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      );
    },
  );}


List<Product> getProductByCategory(String kJackets, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}

Future<List<Product>> loadProductTShirt() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var snapshot = await _firestore.collection(productCollection).get();
  List<Product> products = [];
  for (var doc in snapshot.docs) {
    var data = doc.data();
    products.add(Product(
        pPrice: data[productPrice],
        pLocation: data[productLocation],
        pDescription: data[productDescription],
        pCategory: data[productCategory],
        pName: data[productName],
        pid: doc.id));

    _products = [...products];
    products.clear();
    for (var product in _products) {
      if (product.pCategory == kTshirts) {
        products.add(product);
      }
    }
  }
  return products;
}

Future<List<Product>> loadProductShoes() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var snapshot = await _firestore.collection(productCollection).get();
  List<Product> products = [];
  for (var doc in snapshot.docs) {
    var data = doc.data();
    products.add(Product(
        pPrice: data[productPrice],
        pLocation: data[productLocation],
        pDescription: data[productDescription],
        pCategory: data[productCategory],
        pName: data[productName],
        pid: doc.id));

    _products = [...products];
    products.clear();
    for (var product in _products) {
      if (product.pCategory == kShoes) {
        products.add(product);
      }
    }
  }
  return products;
}
