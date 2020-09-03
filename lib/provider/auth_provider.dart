
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  Future<User> createUserWithMail(String mail, String pass) async{
    final user = (await _auth.createUserWithEmailAndPassword(email: mail, password: pass)).user;
    return user;
  }

  Future<bool> isAuthenticated()async {
    //final currentUser = await _auth.currentUser();
    //return currentUser != null;
    bool estado = false;
    _auth.authStateChanges()
        .listen((User user) {
          if(user == null){
            estado = false;
          }else{
            estado = true;
          }
    });
    return estado;
  }

  Future<User> getCurrentUser()async {
    _auth.authStateChanges()
        .listen((User user) {
        if(user != null) {
        return user;
      }
    });
  }

  Future<void> signOut() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }


}