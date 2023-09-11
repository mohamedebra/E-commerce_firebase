import 'package:api/business_logic/cubit/app_cubit_bloc.dart';
import 'package:api/presentation/screens/user/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fristcontroller = TextEditingController();

    return BlocProvider(
      create: (context) => BuyCubit(),
      child: BlocConsumer<BuyCubit,BuyState>(
        listener: (context,state) {},
        builder: (context,state){
          var cubit = BuyCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,size: 30,color: Colors.blue,),
                  Text('Shopping',style: TextStyle(color: Colors.blue),)
                ],
              ),

            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text('My account',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                      onTap: (){
                        cubit.getImage();
                      },
                      child: Row(
                        children: [
                          // Image(image: AssetImage('images/1.png'),width: 50,),
                          Container(

                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(50)

                              ),
                              width: 50,
                              height: 50,
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.person,size: 25,color: Colors.grey,))),
                          Spacer(),
                          Text('Edit personal photo',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17
                          ),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('First Name',style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),),
                        SizedBox(height: 7,),

                        TextFormField(
                          onTap: (){},
                          controller: fristcontroller,
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last name',style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),),
                        SizedBox(height: 7,),
                        TextFormField(
                          onTap: (){},
                          controller: fristcontroller,
                          decoration: InputDecoration(
                              hintText: 'Last name',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              )

                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text('Phone',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                        Spacer(),
                        Text('+20*********',style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Colors.grey
                        ),),
                        Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text('Password',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Row(
                        children: [
                          Text('Sign Out',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)

                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
