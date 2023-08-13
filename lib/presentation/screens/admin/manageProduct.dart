import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/presentation/screens/admin/editProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({Key? key}) : super(key: key);

  static String id = 'ManageProduct';

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  List<Product> list = [];
  @override
  void initState() {
    super.initState();
    getProduct();
    loadProduct();
  }

  getProduct() async {
    list = await BuyCubit.get(context).products;
  }

  Future<List<Product>> loadProduct() async {
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
          ));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit, BuyState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyCubit.get(context);
          return Scaffold(
            body: FutureBuilder(
                future: loadProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      child: GridView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTapUp: (details) {
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
                                          Navigator.pushNamed(context, EditProduct.id,
                                              arguments: list[index]);
                                        },
                                        child: Text('Edit'),
                                      ),
                                      MyPopupMenuItem(
                                        onClick: () {
                                          for (var num = 0;
                                              num >= list.length;
                                              num++)
                                            cubit
                                                .deleteProduct(list[index].pid);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      )
                                    ]);
                              },
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Image(
                                          fit: BoxFit.fill,
                                          image: AssetImage(snapshot
                                              .data![index].pLocation))),
                                  Positioned(
                                    bottom: 0,
                                    child: Opacity(
                                      opacity: .6,
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].pName),
                                            Text(
                                                '\$ ${snapshot.data![index].pPrice}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: .8),
                      ),
                    );
                  }
                  return Center(child: Text('Loading'));
                }),
          );
        },
      ),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({required this.child, required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
