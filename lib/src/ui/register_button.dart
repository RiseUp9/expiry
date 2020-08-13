import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterButton extends StatelessWidget{
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
  :_onPressed = onPressed,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        child: RaisedButton(
          color: Hexcolor('#1F252E'),
          textColor: Hexcolor('#FF8000'),
          disabledTextColor: Hexcolor('#1F252E'),
          disabledColor: Hexcolor('#FF8000'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      onPressed: _onPressed,
      child: Text('Register'),
    ),
    );
  }

}