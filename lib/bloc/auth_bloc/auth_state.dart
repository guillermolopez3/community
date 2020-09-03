
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object> get props => [];

}

class Uninitialized extends AuthState{}

class AuthInProgress extends AuthState{}

class Authenticated extends AuthState{
  final FirebaseUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState{}

class AuthError extends AuthState{}