import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
//Google sing in
  signInWithGoogle() async {
    // begine sign in process

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //sing in with fetch credentials

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
