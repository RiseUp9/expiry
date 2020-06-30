import 'package:bloc/bloc.dart';
import 'package:expiry/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:expiry/src/bloc/authentication_bloc/authentication_state.dart';
import 'package:expiry/src/bloc/authentication_bloc/bloc.dart';
import 'package:expiry/src/repository/user_repository.dart';
import 'package:meta/meta.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository _userRepository;
  AuthenticationBloc({@required UserRepository userRepository})
:assert(userRepository != null),
  _userRepository = userRepository;

@override
AuthenticationState get initialState => Uninitialized();

@override
  Stream<AuthenticationState> mapEventToState(
  AuthenticationEvent event,
    )async*{
  //implement mapEventToState
  if(event is AppStarted ){
    yield* _mapAppStartedToState();
  }
  if(event is LoggedIn){
 yield* _mapLoggedInToState();
  }
  if(event is LoggedOut){
  yield* _mapToStateLoggedOut();
  }
}
Stream<AuthenticationState> _mapAppStartedToState() async*{
  try{
    final isSignedIn = await _userRepository.isSigneIn();
    if(isSignedIn){
      final user = await _userRepository.getUser();
      yield Authenticated(user);
    }else{
      yield Unauthenticated();
    }
  }catch(_){
    yield Unauthenticated();
  }
}
Stream<AuthenticationState> _mapLoggedInToState() async*{
  yield Authenticated(await _userRepository.getUser());
}
Stream<AuthenticationState>_mapToStateLoggedOut() async*{
  yield Unauthenticated();
  _userRepository.signOut();
}


}