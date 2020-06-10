import 'package:expiry/src/bloc/register_bloc/bloc.dart';
import 'package:expiry/src/repository/user_repository.dart';
import 'package:expiry/src/ui/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget{
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      :assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
          child: RegisterForm(),
        ),
      ),
    );
  }
  
}