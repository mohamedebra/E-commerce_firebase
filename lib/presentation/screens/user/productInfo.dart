import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/data/models/character.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/presentation/screens/user/curtscreen.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 0;
  var scffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)?.settings.arguments as Product?;
    return BlocProvider(
      create: (context) => BuyCubit(),
      child: BlocConsumer<BuyCubit, BuyState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyCubit.get(context);
          return Scaffold(
            key: scffoldKey,
            body: Stack(
              children: [
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Image(image: AssetImage(product!.pLocation),
                      fit: BoxFit.fill,)),
                Material(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .001,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Home_Screen.id);
                                },
                                child: Icon(Icons.arrow_back_ios)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, CartScreen.id);
                              },
                              child: Icon(
                                Icons.shopping_cart,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      Opacity(
                        opacity: .5,
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .3,

                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.pName, style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 10,),
                                Text(product.pDescription, style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),),
                                SizedBox(height: 10,),
                                Text('\$ ${product.pPrice}', style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: MyColors.myYellow,

                                        child: GestureDetector(
                                          onTap: add,
                                          child: SizedBox(
                                            child: Icon(Icons.add),
                                            height: 32,
                                            width: 32,),

                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7,),
                                    Text(_quantity.toString(),
                                      style: TextStyle(fontSize: 45),),
                                    SizedBox(width: 7,),
                                    ClipOval(
                                      child: Material(
                                        color: MyColors.myYellow,

                                        child: GestureDetector(
                                          onTap: remove,
                                          child: SizedBox(
                                            child: Icon(Icons.remove),
                                            height: 32,
                                            width: 32,),

                                        ),
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .08,
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: MyColors.myYellow,
                          onPressed: () {
                            addToCart(context, product);
                            scffoldKey.currentState!.showBottomSheet((
                                context) =>
                                Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 20,
                                    child: Center(child: Text('Add Product'))));
                          },
                          child: Text(
                            'Add to Card'.toUpperCase(), style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }

  remove() {
    if (_quantity > 0)
      setState(() {
        _quantity --;
      });
  }

  add() {
    setState(() {
      _quantity ++;
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      scffoldKey.currentState!.showBottomSheet((context) =>
          Text('you\'ve added this item before'),);
    }
    else {
      cartItem.addProduct(product);
      scffoldKey.currentState!.showBottomSheet((context) =>
          Text('Added to Cart'),);
    } //Text('Added to Cart')
  }
}