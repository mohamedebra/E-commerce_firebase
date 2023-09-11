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
                selectedItemColor: Colors.blue,
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
}
