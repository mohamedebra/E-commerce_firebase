import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/presentation/screens/admin/manageProduct.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/screens/user/home_screen.dart';
import 'package:api/presentation/screens/user/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
   CartScreen({Key? key}) : super(key: key);
  var showCustom = TextEditingController();
  var scffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;

    return BlocProvider(
      create: (context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: (context,state) {},
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.white,
            key: scffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,size: 30,color: Colors.blue,),
                  Text('Shopping',style: TextStyle(color: Colors.blue),)
                ],
              ),
              leading: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Home_Screen.id);
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.blue,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                           showCustomMenu(details,context,products[index]);
                          // BuyCubit.get(context).showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .15,
                          color: Colors.blue[100],
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .15 / 2,
                                backgroundImage: AssetImage(
                                    products[index].pLocation),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(products[index].pName,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight
                                                    .bold),),
                                          SizedBox(height: 15,),
                                          Text('\$ ${products[index].pPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight
                                                    .bold,
                                              fontSize: 15,
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text(products[index].pQuantity
                                          .toString(),style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }, itemCount: products.length,),
                ),
                MaterialButton(
                  height: MediaQuery.of(context).size.height * .07,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: (){
                    showCustomDialog(products,context);
                  },
                color: Colors.blue[300],
                child: Text('order'.toUpperCase()),)
              ],
            ),
          );
        },
      ),
    );
  }

  void showCustomMenu(details,context,products) {
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
              Provider.of<CartItem>(context,listen: false).deleteProduct(products);
              Navigator.pushNamed(context, ProductInfo.id,arguments:products);
            },
            child: Text('Edit'),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(products);
            },
            child: Text('Delete'),
          )
        ]);
  }

  void showCustomDialog(List<Product> product,context)async {
    var price = getTotallPrice(product);
    AlertDialog alertDialog = AlertDialog(
      actions: [
        BlocConsumer<BuyCubit,BuyState>(
          listener: (context,sate){},
          builder: (context, state){
            return MaterialButton(onPressed: (){
              try{
                BuyCubit.get(context).storeOrders({
                kTotallPrice : price,
                kAddress : showCustom.text
              }, product);
                BuyCubit.get(context).storeProduct();


              scffoldKey.currentState!.showBottomSheet((context) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: MyColors.myWhite,
                  child: Center(child: Text('Order Successfully'))));
              Navigator.pop(context);
              }on PlatformException catch(ex){
                print(ex.message);
              }

            },child: Text('Confirm'),);
          },
        )
      ],
      title: Text('Total Price = \$ $price '),
      content: TextFormField(
        controller: showCustom,
        decoration: InputDecoration(
          hintText: 'Enter Your Email'
        ),
      ),

    );
  await  showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  getTotallPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += (product.pQuantity! * int.parse(product.pPrice));
    }
    return price;
  }
}
