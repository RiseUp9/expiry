import 'package:meta/meta.dart';

class RegisterState{
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isUsernameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isUsernameValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isUsernameValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure
  });

  //States
//Empty
  factory RegisterState.empty(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isUsernameValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false
    );
  }
//Loading
  factory RegisterState.loading(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isUsernameValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false
    );
  }

//Failure
  factory RegisterState.failure(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isUsernameValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true
    );
  }
// Success
  factory RegisterState.success(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isUsernameValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false
    );
  }

//Update y Copywith
  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isUsernameValid,
    bool isSubmitting,
    bool isSucess,
    bool isFailure
  }){
    return RegisterState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSucess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isUsernameValid
  }){
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isUsernameValid: isUsernameValid,
        isSubmitting: false,
        isSucess: false,
        isFailure: false
    );
  }

  @override
  String toString() {
    return ''' RegisterState{
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isUsernameValid: $isUsernameValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }


}