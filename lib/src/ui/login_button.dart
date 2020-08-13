import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginButton extends StatelessWidget{
  final VoidCallback _onPressed;
  LoginButton({Key key, VoidCallback onPressed})
  : _onPressed = onPressed,
  super(key : key);
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        child:RaisedButton(
      color: Hexcolor('#1F252E'),
      textColor: Hexcolor('#FF8000'),
      disabledTextColor: Hexcolor('#1F252E'),
      disabledColor: Hexcolor('#FF8000'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      onPressed: _onPressed,
      child: Text('Sign Up'),
    )
    );
  }
         
   }