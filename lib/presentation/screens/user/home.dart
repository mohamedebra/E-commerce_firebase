import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/presentation/screens/store/store.dart';
import 'package:api/presentation/screens/user/curtscreen.dart';
import 'package:api/presentation/wedgit/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabBatIndex = 0;
  List<Product> _product = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyCubit(),
      child: BlocConsumer<BuyCubit, BuyState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: MyColors.myYellow,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  cubit.changeBottonNav(value);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.report), label: 'Report'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.close), label: 'Sign Out'),
                ]),

          );
        },
      ),
    );
  }
  final _store = Store();
  // Widget jacketView() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _store.loadProducts(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         List<Product> products = [];
  //         for (var doc in snapshot.data!.docs) {
  //           var data = doc.data;
  //           products.add(Product(
  //               pid: doc.id,
  //               pPrice: data[kProductPrice],
  //               pName: data[kProductName],
  //               pDescription: data[kProductDescription],
  //               pLocation: data[kProductLocation],
  //               pCategory: data[kProductCategory]));
  //         }
  //         products = [...products];
  //         products.clear();
  //         products = getProductByCategory(kJackets, products);
  //         return GridView.builder(
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             childAspectRatio: .8,
  //           ),
  //           itemBuilder: (context, index) => Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //             child: GestureDetector(
  //               onTap: () {
  //                 Navigator.pushNamed(context, ProductInfo.id,
  //                     arguments: products[index]);
  //               },
  //               child: Stack(
  //                 children: <Widget>[
  //                   Positioned.fill(
  //                     child: Image(
  //                       fit: BoxFit.fill,
  //                       image: AssetImage(products[index].pLocation),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     child: Opacity(
  //                       opacity: .6,
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width,
  //                         height: 60,
  //                         color: Colors.white,
  //                         child: Padding(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: 10, vertical: 5),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 products[index].pName,
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                               Text('\$ ${products[index].pPrice}')
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           itemCount: products.length,
  //         );
  //       } else {
  //         return Center(child: Text('Loading...'));
  //       }
  //     },
  //   );
  // }
}
