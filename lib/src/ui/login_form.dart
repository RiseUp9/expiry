import 'package:expiry/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:expiry/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:expiry/src/bloc/login_bloc/login_bloc.dart';
import 'package:expiry/src/bloc/login_bloc/login_event.dart';
import 'package:expiry/src/bloc/login_bloc/login_state.dart';
import 'package:expiry/src/ui/create_account.dart';
import 'package:expiry/src/ui/google_login_button.dart';
import 'package:expiry/src/ui/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expiry/src/repository/user_repository.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          //three case
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ Text('login feature'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  )
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Loggin'),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }
        },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
        return Padding( padding: EdgeInsets.fromLTRB(30, 80, 30, 10),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(padding:EdgeInsets.symmetric(vertical:40),
              ),

              new SizedBox(
                height: 50,
                child:TextFormField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: InputDecoration(
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
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_){
                    return !state.isEmailValid? 'Invalid Email': null;
                  },
                ),
              ),

              Padding(padding:EdgeInsets.symmetric(vertical: 5),
              ),
          new SizedBox(
            height: 50,
              child:TextFormField(
                textAlign: TextAlign.center,
                controller: _passwordController,
                decoration: InputDecoration(
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
                    hintText: " Password",
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF1F252E))
                ),
                obscureText: true,
                autovalidate: true,
                autocorrect: false,
                validator: (_){
                  return !state.isPasswordValid? 'Invalid Password': null;
                },
              ),
          ),

              Padding(padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //three Button
                  //LoginButton
                  LoginButton(
                    onPressed: isLoginButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                  //GoogleLoginButton
                  GoogleLoginButton(),
                  //createAccounButton
                  CreateAcountButton(userRepository: _userRepository,),
                ],
              ),
              )
            ],
          ),
        ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChange(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChange(password: _passwordController.text));
  }

  void _onFormSubmitted(){
  _loginBloc.add(
    LoginWithCredentialsPressed(
      email: _emailController.text,
      password: _passwordController.text
    )
  );
  }

}