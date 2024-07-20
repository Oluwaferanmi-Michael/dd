import 'package:dd/core/resources/constants/auth_constants.dart';
import 'package:dd/core/util/logger.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:dd/core/util/typedefs.dart';

import '../../../../core/resources/data_state.dart';
import '../repository/auth_repository.dart';

class AuthenticationImpl implements AuthenticationRepository{
  const AuthenticationImpl();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  UID? get userId => currentUser?.uid;
  bool get isLoggedIn => userId != null;
  Email? get email => currentUser?.email;


  @override
  Future<DataState<AuthState>> signInWithEmail(Email email) async {
    final actionCodeSettings = ActionCodeSettings(url: 'https://localhost/', handleCodeInApp: true, androidPackageName: 'com.example.dd');
    try{
      await FirebaseAuth.instance.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);      
      return const DataSuccess(true);
    } catch(e) {
      e.log();
      return DataFailed(e);
    }
  } 
  
  
  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    
  }
  
  
  @override
  Future<DataState<AuthState>> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        AuthConstants.emailScope
      ]
    );

    final signIn = await googleSignIn.signIn();

    if (signIn == null) {return const DataFailed(false);}

    final googleAuth = await signIn.authentication;

    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    try {
      FirebaseAuth.instance.signInWithCredential(
        googleAuthCredential
      );

      return const DataSuccess(true);
    } catch (e) {
      e.log();
      return const DataFailed(false);
    }
  }

}