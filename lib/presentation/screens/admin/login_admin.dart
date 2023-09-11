import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/constants/string.dart';
import 'package:api/data/repository/chercter_repostiory.dart';
import 'package:api/presentation/screens/admin/adminHome.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/screens/user/home_screen.dart';
import 'package:api/presentation/screens/user/loginScreen.dart';
import 'package:api/presentation/screens/user/sign_up_screen.dart';
import 'package:api/presentation/wedgit/constants_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Admin extends StatefulWidget {
  static String id = "Login_Admin";

  Login_Admin({Key? key}) : super(key: key);

  @override
  State<Login_Admin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login_Admin> {
  final GlobalKey<FormState> _globallKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _password = TextEditingController();

  final adminPassword = 'Admin1234';

  bool keepMeLoggedIn = false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var scffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: ( context,  state) {
          if(state is BuyScsussSginIn){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminHome()));
          }
          if(state is BuyErrorSginIn){
            scffoldKey.currentState!.showBottomSheet((context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Text((state).error.toString()),
              ),
            ));
          }} ,
        builder: ( context, state)  {
          var cubit = BuyCubit.get(context);
          ModelHud modelHud = ModelHud();
          return Scaffold(
            key: scffoldKey,
            backgroundColor: Colors.blue[100],
            body: ModalProgressHUD(
              inAsyncCall: Provider.of<ModelHud>(context).isLoading,
              child: Form(
                key: _globallKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(90.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .15,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image(image: AssetImage('images/icons8-buy-80.png')),
                            Positioned(
                              bottom: 0,
                              child: Text('Buy it',style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontSize: 25
                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,bottom: 10),
                      child: Text('Welcome My Admin',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: MyColors.myYellow,
                        obscureText:  false,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Email is empty !';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.blue,
                            ),
                            filled: true,
                            fillColor: Colors.white60,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color:Colors.white
                                )
                            )
                        ),
                        controller: _email,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.white),
                            child: Checkbox(
                              checkColor: MyColors.kSecondaryColor,
                              activeColor: MyColors.myYellow,
                              value: keepMeLoggedIn,
                              onChanged: (value) {
                                setState(() {
                                  keepMeLoggedIn = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Remmeber Me ',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: MyColors.myYellow,
                        obscureText:  true,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Password is empty !';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            filled: true,
                            fillColor: Colors.white60,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color:Colors.white
                                )
                            )
                        ),
                        controller: _password,
                      ),
                    ),
                    SizedBox(height: height *.05,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: (){
                          if(keepMeLoggedIn == true)
                          {
                            keepUserLogin();
                          }
                          if(_globallKey.currentState!.validate()){
                            try{
                              cubit.signIn(email: _email.text, password: _password.text);
                            }on PlatformException catch(e){

                              scffoldKey.currentState!.showBottomSheet((context) => Container(
                                width: double.infinity,
                                height: 50,
                                child: Text('${e.message}'),
                              ));
                            }
                          }
                          modelHud.changeisLoading(false);
                        },
                        color: MyColors.myGrey,
                        child: Text('Login',style: TextStyle(color: Colors.blue),),),
                    ),
                    SizedBox(height: height *.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don\'t have an account ? ",style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Sign_Up_Screen.id);
                          },
                          child: Text("Sign Up",style: TextStyle(
                              fontSize: 16
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children:  [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);

                            },
                            child: Text(
                              'I\'m an admin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Provider.of<AdminMode>(context).isAdmin
                                      ?  Colors.blue
                                      : Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text(
                              'I\'m a user',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                  Provider.of<AdminMode>(context, listen: true)
                                      .isAdmin
                                      ? Colors.white
                                      :  Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void keepUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}

