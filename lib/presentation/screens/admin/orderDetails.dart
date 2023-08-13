import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var  docid = ModalRoute.of(context)!.settings.arguments;
    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: ( context,  state) {} ,
        builder: ( context, state)  {
          var cubit = BuyCubit.get(context);

          return Scaffold(
            body: StreamBuilder(
              stream: cubit.loadOrderDetails(docid),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  List<Product> products = [];
                  for (var doc in snapshot.data!.docs) {
                    var data = doc.get;
                    products.add(Product(
                      pPrice: doc.get(productPrice),
                      pLocation: doc.get(productLocation),
                      pDescription: doc.get(productDescription),
                      pCategory: doc.get(productCategory),
                      pName: doc.get(productName),
                    ));
                  }
                  return ListView.builder(itemBuilder: (context,index){
                    Container(
                      height: MediaQuery.of(context).size.height * .2,
                      color: MyColors.myWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Product Name = ${products[index].pName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text('Price = ${products[index].pPrice}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                            SizedBox(height: 10,),
                            Text('Quantity  = ${products[index].pQuantity}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),

                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,);
                }
                else{
                 return Center(child: Text('Loading order Details'));
                }


              },
            ),
          );
        },
      ),
    );
  }
}
