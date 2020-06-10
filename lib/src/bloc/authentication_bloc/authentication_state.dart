import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();

  @override
List<Object> get props => [];
}


//state


//Not initialized-> splash screen
class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'Not initialized';
}
//Authenticated-> home
class Authenticated extends AuthenticationState{
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
String toString() => 'Authenticated - displayName:$displayName';
}

//Not Authenticated->login
class Unauthenticated extends AuthenticationState{
  @override
  String toString() => 'Not Authenticaded';
}
