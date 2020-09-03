
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props =>[];
}

class AppLaunched extends AuthEvent{}

class LoggedInWithGoogle extends AuthEvent{}

class CreateUserWithMail extends AuthEvent{
  final String mail;
  final String pass;

  const CreateUserWithMail(this.mail, this.pass);

  @override
  List<Object> get props =>[mail,pass];
}

class LoggedOut extends AuthEvent{}

