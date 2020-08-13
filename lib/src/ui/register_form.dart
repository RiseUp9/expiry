import 'package:expiry/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:expiry/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:expiry/src/bloc/register_bloc/bloc.dart';
import 'package:expiry/src/ui/home_screen.dart';
import 'package:expiry/src/ui/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Dos variable

  String username;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _usernameController.addListener(_onUsernameChanged);
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        //isSubmitting
        if (state.isSubmitting){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                  content:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Registering'),
                      CircularProgressIndicator()
                    ],
                  ),
                )
            );
        }
        //isisSuccess
    if(state.isSuccess){
    BlocProvider.of< AuthenticationBloc >(context)
        .add(LoggedIn());
    Navigator.of(context).pop();
    }
        if(state.isFailure) {
          //state is failure
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Registration failure'),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                )
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state){
          return Padding(
            padding: EdgeInsets.fromLTRB(30, 80, 30, 10),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(padding:EdgeInsets.symmetric(vertical:40),
                  ),

                  //textName
                  new SizedBox(
                      child:TextFormField(
                        textAlign: TextAlign.center,
                        controller: _usernameController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffafafa)),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffafafa)),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            fillColor: Color(0xFFFFFFFF),
                            filled: true,
                            hintText: "Username",
                            hintStyle: TextStyle(fontSize: 13, color: Color(0xFF1F252E), height: 1.0)
                        ),
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        autovalidate: true,
                        validator: (_){
                          return !state.isUsernameValid ? 'Invalid username' : null;
                        },
                      )
                  ),
                  Padding(padding:EdgeInsets.symmetric(vertical: 4),
                  ),
                  //textEmail
                  new SizedBox(
                      child:TextFormField(
                        textAlign: TextAlign.center,
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffafafa)),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffafafa)),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                            fillColor: Color(0xFFFFFFFF),
                            filled: true,
                            hintText: " Email",
                            hintStyle: TextStyle(fontSize: 13, color: Color(0xFF1F252E), height: 1.0)
                        ),
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autovalidate: true,
                        validator: (_){
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      )
                  ),
                  //textPassword
                  Padding(padding:EdgeInsets.symmetric(vertical: 4),
                  ),
                 new SizedBox(
                   child: TextFormField(
                     textAlign: TextAlign.center,
                     controller: _passwordController,
                     decoration: InputDecoration(
                         contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Color(0xfffafafa)),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                       ),
                       focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Color(0xfffafafa)),
                       borderRadius: BorderRadius.all(Radius.circular(15.0)),
                       ),
                       fillColor: Color(0xFFFFFFFF),
                       filled: true,
                       hintText: "Password",
                         hintStyle: TextStyle(fontSize: 13, color: Color(0xFF1F252E), height: 1.0)
                     ),
                     obscureText: true,
                     autocorrect: false,
                     autovalidate: true,
                     validator:(_){
                       return !state.isPasswordValid ? 'Invalid password' : null;
                     },
                   ),
                 ),
                  Padding(padding:EdgeInsets.symmetric(vertical: 5),
                  ),
                  //button
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
        Submitted(
            email: _emailController.text,
            password: _passwordController.text,
            username: _usernameController.text
        )
    );


  }
  void _onEmailChanged() {
    _registerBloc.add(
        EmailChanged(email: _emailController.text)
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
        PasswordChanged(password: _passwordController.text)
    );
  }
  void _onUsernameChanged(){
    _registerBloc.add(
        UsernameChanged(username: _usernameController.text)
    );
  }

}


