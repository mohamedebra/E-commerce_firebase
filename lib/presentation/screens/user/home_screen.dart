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

    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: BlocProvider(
            create: (context) => BuyCubit(),
            child: BlocConsumer<BuyCubit, BuyState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = BuyCubit.get(context);
                return Scaffold(
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
                          Text(
                            'Jacket',
                            style: TextStyle(
                                color: _tabBatIndex == 0
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: _tabBatIndex == 0 ? 16 : null),
                          ),
                          Text(
                            'Trouser',
                            style: TextStyle(
                                color: _tabBatIndex == 1
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: _tabBatIndex == 1 ? 16 : null),
                          ),
                          Text(
                            'T-Shirt',
                            style: TextStyle(
                                color: _tabBatIndex == 2
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: _tabBatIndex == 2 ? 16 : null),
                          ),
                          Text(
                            'Shoes',
                            style: TextStyle(
                                color: _tabBatIndex == 3
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: _tabBatIndex == 3 ? 16 : null),
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
        Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * .09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover'.toUpperCase(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: const Icon(
                        Icons.shopping_cart,
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
