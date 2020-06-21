import 'file:///C:/Users/Rubyx/AndroidStudioProjects/expiryv1/expiry/lib/src/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:expiry/src/repository/user_repository.dart';

class CreateAcountButton extends StatelessWidget{
  final UserRepository _userRepository;

CreateAcountButton({ Key key, @required UserRepository userRepository})
  :assert(userRepository!=  null),
  _userRepository = userRepository,
  super(key: key);

  @override
  Widget build(BuildContext context) {
  return FlatButton(
    child: Text('Create Account'),
    onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return RegisterScreen(userRepository: _userRepository,);
      })
      );
    },
  );
  }}