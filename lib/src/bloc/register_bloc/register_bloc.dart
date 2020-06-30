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
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
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
    // Si el evento es Submitted
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
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
      String email, String password
      ) async*{
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
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
        "email" : usuarioFirebase.email
      }
  ).then((_){
    print("exito!!!");
  });
  }

}