import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BlueButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // elevation: 0.0,
      // highlightElevation: 5,
      // color: Colors.black,
      onPressed: this.onPressed,
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}