import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/presentation/screens/user/curtscreen.dart';
import 'package:api/presentation/wedgit/productView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home_Screen extends StatefulWidget {
  static String id = "HomePage";

  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    int _tabBatIndex = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart,size: 30,color: Colors.blue,),
            Text('Shopping',style: TextStyle(color: Colors.blue,
            ),)
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, CartScreen.id);
            }, icon: Icon(Icons.shopping_cart),color: Colors.black,),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text('Categories',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: BlocProvider(
                create: (context) => BuyCubit(),
                child: BlocConsumer<BuyCubit, BuyState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = BuyCubit.get(context);
                    return Scaffold(
                      backgroundColor: Colors.white,

                      appBar: AppBar(
                        backgroundColor: Colors.white10,
                        elevation: 0,
                        bottom: TabBar(
                            onTap: (value) {
                              setState(() {
                                _tabBatIndex = value;
                              });
                            },
                            tabs: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(Icons.shape_line),
                                  ),
                                  SizedBox(height: 7,),
                                  Text('Jacket',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11),)

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(Icons.qr_code),
                                  ),
                                  SizedBox(height: 7,),

                                  Text('Trouser',                            style: TextStyle(
                                    color: Colors.blue,
                                      fontSize: 11),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(Icons.menu_sharp),
                                  ),
                                  SizedBox(height: 7,),

                                  Text('T-Shirt',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(Icons.telegram),
                                  ),
                                  SizedBox(height: 7,),
                                  Text('Shoes',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 11),)
                                ],
                              ),
                            ]),
                      ),
                      body: TabBarView(
                        children: [
                          jacketView(),
                          trouserVeiw(),
                          tShirtVeiw(),
                          shoesVeiw(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
