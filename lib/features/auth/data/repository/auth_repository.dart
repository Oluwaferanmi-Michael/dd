import 'package:dd/core/resources/data_state.dart';
import 'package:dd/core/util/typedefs.dart';

abstract class AuthenticationRepository {
  Future<DataState<AuthState>> signInWithEmail(Email email);

  Future<void> logOut();

  Future<DataState<AuthState>> signInWithGoogle();

}