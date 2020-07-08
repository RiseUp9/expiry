import 'package:bloc/bloc.dart';
import 'package:expiry/src/bloc/register_bloc/bloc.dart';
import 'package:expiry/src/repository/user_repository.dart';
import 'package:expiry/src/util/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  String miUsername = "";
  final firestoreIntance = Firestore.instance;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegisterState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged && event is! UsernameChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged || event is UsernameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
      RegisterEvent event,
      ) async* {
    // Tres casos
    // Si el evento es EmailChanged
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    // Si el evento es PasswordChanged
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    }
    // Si el evento es Submitted
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password, event.username);
    }
  }

  Stream<RegisterState>_mapUsernameChangedToState(String username) async*{
    yield state.update(
      isUsernameValid: Validators.isValidUsername(username)
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async*{
    yield state.update(
        isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email, String password, String username
      ) async*{
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
      print("---------------------");
      print(username);
      print("--------------------");
      miUsername = username;
      yield RegisterState.success();

  // mandar llamar la funcion para registrar en la base de datos.
      _seRegistro();
    } catch (_) {
      yield RegisterState.failure();

      // aquí no se pudó, por alguna razón
    }
  }

  // --users
  //      --- id 21331
  //      -------- mail : rubi@sexy.com
  //      -------- nombre : rubi
  //      -------- productos :

  //      --- id 12314
  //      --------- nombre : gerardo


  void _seRegistro() async {
    var usuarioFirebase = await FirebaseAuth.instance.currentUser();

    firestoreIntance.collection("users").document(usuarioFirebase.uid).setData(
      {
        "email" : usuarioFirebase.email,
        "username" : miUsername
      }
  ).then((_){
    print("exito!!!");
  });
  }

}