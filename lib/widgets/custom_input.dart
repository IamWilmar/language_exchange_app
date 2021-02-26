import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            offset: Offset(3, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: this.textController,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.hint,
        ),
        onChanged: (val){
          
        },
      ),
    );
  }
}