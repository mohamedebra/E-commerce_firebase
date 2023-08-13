import 'package:api/constants/colors.dart';
import 'package:flutter/material.dart';

class ConstantTextField extends StatelessWidget {
  final String texthint;
  final IconData icon;
  final TextInputType keyboardType;
  onClick(String val) {}
  _errorMessage(String str) {
    switch (texthint) {
      case "Enter Your name":
        return "name is empty !";
      case "Enter Your Email":
        return "Email is empty !";
      case "Enter Your Password":
        return "Password is empty !";
    }
  }

  const ConstantTextField(
      {Key? key,
      required this.texthint,
      required this.icon,
      required this.keyboardType,
      required Function(String val) onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        cursorColor: MyColors.myYellow,
        obscureText: texthint == "Enter Your Password" ? true : false,
        validator: (value) {
          if (value!.isEmpty) {
            return _errorMessage(texthint);
          }
        },
        decoration: InputDecoration(
            hintText: texthint,
            prefixIcon: Icon(
              icon,
              color: MyColors.myYellow,
            ),
            filled: true,
            fillColor: MyColors.myWhite,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: MyColors.myWhite)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: MyColors.myWhite))),
        onChanged: onClick,
      ),
    );
  }
}
