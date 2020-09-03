
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> createUserWithMail(String mail, String pass) async{
    final user = (await _auth.createUserWithEmailAndPassword(email: mail, password: pass)).user;
    return user;
  }

  Future<bool> isAuthenticated()async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser()async {
    return await _auth.currentUser();
  }

  Future<void> signOut() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }


}