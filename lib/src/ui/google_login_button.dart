import 'package:expiry/src/bloc/login_bloc/login_bloc.dart';
import 'package:expiry/src/bloc/login_bloc/login_event.dart';
import  'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:expiry/src/bloc/login_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
      onPressed: (){
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Loggin in...'),
                    CircularProgressIndicator(),
                  ],
                )
            )
        );
        BlocProvider.of<LoginBloc>(context).add(
            LoginWhitGooglePressed()
        );
      },
        borderRadius: 15.0
    );
  }
}
