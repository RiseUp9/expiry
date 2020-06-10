import 'package:bloc/bloc.dart';
import 'package:expiry/src/bloc/login_bloc/bloc.dart';
import 'package:expiry/src/bloc/login_bloc/login_event.dart';
import 'package:expiry/src/bloc/login_bloc/login_state.dart';
import 'package:expiry/src/util/validators.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:expiry/src/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  UserRepository _userRepository;
  //constructor
  LoginBloc({@required UserRepository userRepository})
  :assert(userRepository!= null),
  _userRepository = userRepository;

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(Stream<LoginEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event){
      return (event is! EmailChange && event is! PasswordChange);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChange || event is PasswordChange);
    }).debounceTime(Duration(milliseconds:300 ));

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]) , transitionFn,);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event, ) async* {
  if(event is EmailChange){
    yield* _mapEmailChangedToState(event.email);
  }
  if(event is PasswordChange){
    yield* _mapPasswordChangedToState(event.password);
  }
  if(event is LoginWhitGooglePressed){
    yield* _mapLoginWithGooglePressedToState();
  }
  if(event is LoginWithCredentialsPressed){
    yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password
    );
  }
  }


  Stream<LoginState> _mapEmailChangedToState(String email) async*{
    yield state.update(
        isEmailValid: Validators.isValidEmail(email)
    );
  }
  Stream<LoginState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async*{
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email, String password
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}