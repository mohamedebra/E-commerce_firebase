import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/presentation/screens/admin/addProducts.dart';
import 'package:api/presentation/screens/admin/adminHome.dart';
import 'package:api/presentation/screens/admin/editProduct.dart';
import 'package:api/presentation/screens/admin/manageProduct.dart';
import 'package:api/presentation/screens/admin/orderDetails.dart';
import 'package:api/presentation/screens/admin/orderProduct.dart';
import 'package:api/presentation/screens/user/curtscreen.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/screens/user/loginScreen.dart';
import 'package:api/presentation/screens/user/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/user/productInfo.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

   MyApp({Key? Key}) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snapshot){
      if(!snapshot.hasData){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text('Loading....'),
            ),
          ),
        );
      }
      else{
        isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;

        return BlocProvider(
          create: (BuildContext context) => BuyCubit(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              theme: ThemeData(),
              initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
              debugShowCheckedModeBanner: false,
              routes: {
                LoginScreen.id: (context) => LoginScreen(),
                Sign_Up_Screen.id: (context) => Sign_Up_Screen(),
                // AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
                ManageProduct.id: (context) => ManageProduct(),
                EditProduct.id: (context) => EditProduct(),
                HomePage.id: (context) => HomePage(),
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                OrderProduct.id: (context) => OrderProduct(),
                OrderDetails.id: (context) => OrderDetails(),
              },
            ),
          ),
        );
      }
    },
    future: SharedPreferences.getInstance(),);
  }
}
