import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/presentation/screens/admin/adminHome.dart';
import 'package:api/presentation/screens/user/home.dart';
import 'package:api/presentation/wedgit/constants_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Sign_Up_Screen extends StatelessWidget {
  static String id = "SignUpScreen";
  GlobalKey<FormState> _globallKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var scffoldKey = GlobalKey<ScaffoldState>();

    var controlleremail = TextEditingController();
    var controllername = TextEditingController();
    var controllerPassword = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: ( context, state) {
          if(state is BuyScsuss){
            Navigator.pushNamed(context, AdminHome.id);
          }
          if(state is BuyError){
            scffoldKey.currentState!.showBottomSheet((context) => Container(
                height: 50,
                width: double.infinity,
                child: Text((state).error)));
          }
        },
        builder: (BuildContext context, state) {
          var cubit = BuyCubit.get(context);
          return Scaffold(
            key: scffoldKey,
            backgroundColor: MyColors.myYellow,
            body: ModalProgressHUD(
              inAsyncCall: cubit.isLoading,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ConstantTextField(texthint: 'Enter Your name', icon: Icons.perm_identity, keyboardType: TextInputType.visiblePassword, onClick: (val){},),
                    ),
                    SizedBox(height: height *.02,),
                    // email
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
                              Icons.lock,
                              color: MyColors.myYellow,
                            ),
                            filled: true,
                            fillColor: MyColors.myWhite,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: MyColors.myWhite
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: MyColors.myWhite
                                )
                            )
                        ),
                        controller: _email,
                      ),
                    ),
                    SizedBox(height: height *.02,),
                    // password
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
                              color: MyColors.myYellow,
                            ),
                            filled: true,
                            fillColor: MyColors.myWhite,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: MyColors.myWhite
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: MyColors.myWhite
                                )
                            )
                        ),
                        controller: _password,
                      )
                    ),
                    SizedBox(height: height *.05,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Builder(
                        builder:(context) =>  MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          onPressed: ()async{
                            cubit.changeLoading(true);
                            if(_globallKey.currentState!.validate()){
                               _globallKey.currentState!.save();
                               try{
                                await cubit.signUp(email: _email.text, password: _password.text);

                               }catch(e){
                                Scaffold.of(context).showBottomSheet((context) => Container(
                                  height: 50,
                                  color: Colors.grey,
                                  child: Text(e.toString()),
                                ));
                              }
                            }
                            cubit.changeLoading(false);
                          },
                          color: MyColors.myGrey,
                          child: Text('Sign Up',style: TextStyle(color: MyColors.myWhite),),),
                      ),
                    ),
                    SizedBox(height: height *.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do have an account ? ",style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Text("Login",style: TextStyle(
                              fontSize: 16
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
