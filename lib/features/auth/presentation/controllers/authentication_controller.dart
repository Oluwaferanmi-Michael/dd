import 'package:dd/core/resources/data_state.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/auth/data/data_sources/auth_impl.dart';
import 'package:dd/features/auth/domain/entities/user_model.dart';
import 'package:dd/features/auth/presentation/states/authentication_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_controller.g.dart';

@riverpod
class AuthService extends _$AuthService {
   
  @override
  AuthenticationStateRepository build() {
    if (_authImpl.isLoggedIn){
     return AuthStateSuccess(
          user: UserModel(
            id: _authImpl.userId),
          isLoggedIn: _authImpl.isLoggedIn
        );
    }
      return _unknown;
    }

  final _authImpl = const AuthenticationImpl();

  get _loading => const AuthStateLoading(); 
  get _unknown => const AuthStateUnknown(isLoggedIn: false, user: UserModel.unknown());
  // const AsyncData<AuthStateUnknown>(AuthStateUnknown(isLoggedIn: false, user: UserModel.unknown()));

  Future<void> logOut() async {
    state = _loading;
    await _authImpl.logOut();
    state = _unknown;
  }
  
  
  Future<AuthState> signInWithEmail(Email email, Username username) async {
    state = _loading;
    try {
      final dataState = await _authImpl.signInWithEmail(email);
      if (dataState is DataSuccess && dataState.data == true) {
        state = AuthStateSuccess(
          user: UserModel(
            id: _authImpl.currentUser?.uid,
            username: username
            ),
          isLoggedIn: true);
        
      }

      if(dataState is DataFailed) {
        state =  const AuthStateUnknown();
      }
      return true;
    } catch (e) {
      e.log();
      return false;
    }
    
  }

  Future<AuthState> signInWithGoogle() async {
    state = _loading;
    try {
      // final authState = 
      await _authImpl.signInWithGoogle();
      final id = _authImpl.userId;


      final future = AuthStateSuccess(
          user: UserModel(
            id: id,
            ), 
          isLoggedIn: true,
        );

        state = future;
      return true;
    } catch (e) {
      e.log('auth controller google sign in: ');
      return false;
    }
    
  } 
}