import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent{
  final String email;

  EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChange { email:$email}';
}

class PasswordChanged extends RegisterEvent{
  final String password;

  PasswordChanged({@required this.password});

  @override
  List<Object> get props=>[password] ;

  String toString() => 'PasswordChange{password :  $password}';

}

class Submitted extends RegisterEvent{
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'Submitted {email: $email, password: $password}';
}