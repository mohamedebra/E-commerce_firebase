import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:api/presentation/screens/admin/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProduct extends StatelessWidget {
  static String id = 'OrderProduct';
  const OrderProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: ( context,  state) {} ,
        builder: ( context, state)  {
          var cubit = BuyCubit.get(context);
          return Scaffold(
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
                  return ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].id);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                            color: Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Total Price = ${orders[index].totalPrice.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 10,),
                                Text('Email Address = ${orders[index].address}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: orders.length,);
                }

              },
            ),
          );
        },
      ),
    );
  }
}
