import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/presentation/screens/admin/orderDetails.dart';
import 'package:api/presentation/screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    List<Order> orders = [];
    getTotallPrice(List<Product> products) {
      var price = 0;
      for (var product in products) {
        price = (product.pQuantity! * int.parse(product.pPrice));
      }
      return price;
    }


    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: ( context,  state) {} ,
        builder: ( context, state)  {
          var price = getTotallPrice(products);

          var cubit = BuyCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text('Reports',style: TextStyle(
                  color: Colors.black
              ),),
              leading: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Home_Screen.id);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),

            body: StreamBuilder(
              stream: cubit.loadOrders(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Text('There is no orders');
                }
                else {
                  List<Order> orders = [];
                  for (var doc in snapshot.data!.docs) {
                    orders.add(Order(
                      id: doc.id,
                      address:doc.get(kAddress),
                      totalPrice: doc.get(kTotallPrice),
                    ));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .15,
                              color: MyColors.myWhite,
                              child: Container(
                                margin: EdgeInsets.all(7),

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
                                                left: 15),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(orders[index].address,),
                                                SizedBox(height: 7,),
                                                Text('\$ ${orders[index].totalPrice}',),
                                                SizedBox(height: 7,),
                                                Text('Product Name = ${products[index].pName}',),
                                                SizedBox(height: 7,),
                                                Text('Price = ${products[index].pPrice}'),
                                                SizedBox(height: 7,),
                                                Text('Quantity  = ${products[index].pQuantity}'),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child:  Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                              ],
                                            ),
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
                    ],
                  );
                }

              },
            ),
          );
        },
      ),
    );
  }
}
