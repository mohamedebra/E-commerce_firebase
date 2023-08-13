import 'package:api/constants/colors.dart';
import 'package:api/presentation/screens/admin/addProducts.dart';
import 'package:api/presentation/screens/admin/manageProduct.dart';
import 'package:api/presentation/screens/admin/orderProduct.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);
  static String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myYellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          MaterialButton(
            color: MyColors.myWhite,
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          MaterialButton(
            color: MyColors.myWhite,
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text('Edit Product'),
          ),
          MaterialButton(
            color: MyColors.myWhite,
            onPressed: () {
              Navigator.pushNamed(context, OrderProduct.id);
            },
            child: Text('View Product'),
          ),
        ],
      ),
    );
  }
}
