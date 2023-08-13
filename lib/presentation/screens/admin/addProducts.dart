import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/constants/colors.dart';
import 'package:api/data/models/character.dart';
import 'package:api/presentation/wedgit/constants_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProduct extends StatelessWidget {
   AddProduct({Key? key}) : super(key: key);
  static String id = 'AddProduct';
  var  _location = TextEditingController();
  var  _name = TextEditingController();
  var  _price = TextEditingController();
  var  _description = TextEditingController();
  var  _category = TextEditingController();
  var _globallKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: (context,state){},
          builder: (context ,state){
          var cubit = BuyCubit.get(context);
          return Scaffold(
            body: Form(
              key: _globallKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextFormField(
                      controller: _name,
                      cursorColor: MyColors.myYellow,
                      obscureText:  false,
                      decoration: InputDecoration(
                          hintText: 'Product Name',
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextFormField(
                      controller: _price,
                      cursorColor: MyColors.myYellow,
                      decoration: InputDecoration(
                          hintText: 'Product Price',
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextFormField(
                      controller: _description,
                      cursorColor: MyColors.myYellow,
                      obscureText:  false,
                      decoration: InputDecoration(
                          hintText: 'Product Description',
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextFormField(
                      controller: _category,
                      cursorColor: MyColors.myYellow,
                      obscureText:  false,
                      decoration: InputDecoration(
                          hintText: 'Product category',
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: TextFormField(
                      controller: _location,
                      cursorColor: MyColors.myYellow,
                      obscureText:  false,
                      decoration: InputDecoration(
                          hintText: 'Product Location',
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
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: Colors.grey[300],
                    onPressed: (){
                      if(_globallKey.currentState!.validate()){
                        _globallKey.currentState!.save();
                        cubit.addProduct(
                          Product(
                            pName: _name.text,
                            pCategory: _category.text,
                            pDescription: _description.text,
                            pLocation: _location.text,
                            pPrice: _price.text,

                          )
                        );
                      }
                    },
                    child: const Text('Add Product'),)

                ],
              ),
            ),
          );
          },
      ),
    );
  }
}
