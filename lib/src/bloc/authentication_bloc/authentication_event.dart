import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object> get props =>[];

}
//Tres eventos
//App started
class AppStarted extends AuthenticationEvent{}
//LoggedIn
class LoggedIn extends AuthenticationEvent{}
//LoggedOut
class LoggedOut extends AuthenticationEvent{}