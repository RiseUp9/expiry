import './bloc.dart';

class LoginState{
//defining variables
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;
  //contructor
LoginState({this.isEmailValid, this.isPasswordValid, this.isSubmitting, this.isSuccess, this.isFailure});
//STATES
//Empty
factory LoginState.empty(){
  return LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );
}
//Loading
factory LoginState.loading(){
  return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false
  );
}
//Failure
factory LoginState.failure(){
  return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true
  );
}
//success
factory LoginState.success(){
  return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false
  );
}
//functions aditionals- copywith-update
  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure}) {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }
LoginState update({
bool isEmailValid,
bool isPasswordValid
}){
  return copyWith(
    isEmailValid: isEmailValid,
    isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
     isFailure:false
  );
}
@override
  String toString(){
  return ''' LoginState{
  isEmailValid:$isEmailValid ,
    isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
     isFailure:$isFailure
  }
  ''';
}


}




