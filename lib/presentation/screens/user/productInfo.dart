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
            backgroundColor: Colors.white,
            key: scffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(Icons.keyboard_arrow_left_outlined,color: Colors.blue,),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,size: 30,color: Colors.blue,),
                  Text('Shopping',style: TextStyle(color: Colors.blue),)
                ],
              ),

            ),
            body: Column(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size.height * .5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Image(image: AssetImage(product!.pLocation),
                      fit: BoxFit.fill,)),

                Container(
                  color: Colors.white,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .33,

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(product.pName, style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20,),
                        Text(product.pDescription, style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]
                        ),),
                        SizedBox(height: 20,),
                        Text('\$ ${product.pPrice}', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: Colors.blue[200],
                                child: GestureDetector(
                                  onTap: add,
                                  child: SizedBox(
                                    child: Icon(Icons.add,size: 18,),
                                    height: 25,
                                    width: 25,),

                                ),
                              ),
                            ),
                            SizedBox(width: 7,),
                            Text(_quantity.toString(),
                              style: TextStyle(fontSize: 20),),
                            SizedBox(width: 7,),
                            ClipOval(
                              child: Material(
                                color: Colors.blue[200],

                                child: GestureDetector(
                                  onTap: remove,
                                  child: SizedBox(
                                    child: Icon(Icons.remove,size: 18,),
                                    height: 25,
                                    width: 25,),

                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.blue[300],
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