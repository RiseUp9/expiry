import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';


abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props =>[];
}
//emailChange
class EmailChange extends LoginEvent{
  final String email;
  const EmailChange ({@required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChange{email: $email}';
}

//passwordChange
class PasswordChange extends LoginEvent{
  final String password;
  const PasswordChange ({@required this.password});
  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChange{password: $password}';
}
//submitted
class Submitted extends LoginEvent{
  final String email;
  final String password;
  const Submitted ({@required this.email, @required this.password});
  @override
  List<Object> get props => [email ,password];
  @override
  String toString() => 'Submitted  {email: $email, password $password}';
}
//loginWhitGooglePressed
class LoginWhitGooglePressed extends LoginEvent{}

//loginWhitGoogleCredentialsPressed
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginWithCredentials {email: $email, password: $password}';
}