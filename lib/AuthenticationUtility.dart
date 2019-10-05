import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationUtility{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<void> signInAnonymous(){
    return _firebaseAuth.signInAnonymously();
  }

  Future<void> signInWithGoogle()async{
    GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    return _firebaseAuth.signInWithCredential(authCredential);
  }

}