
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmarcas/provider/auth_provider.dart';

class AuthRepository{
  AuthProvider _provider = AuthProvider();

  Future<User> signInGoogle() => _provider.signInGoogle();
  Future<User> createUserWithMail(String mail, String pass) => _provider.createUserWithMail(mail, pass);
  Future<bool> isAuthenticated() => _provider.isAuthenticated();
  Future<User> getCurrentUser() => _provider.getCurrentUser();
  Future<void> signOut() => _provider.signOut();
}