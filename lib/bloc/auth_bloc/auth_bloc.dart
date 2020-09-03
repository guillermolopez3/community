import 'package:cmarcas/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_b.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthRepository _repository = AuthRepository();

  AuthBloc() : super(Uninitialized());

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is AppLaunched){
      yield* _mapAppLaunchedToMap();
    }else if(event is CreateUserWithMail){
      yield* _createUserMail(event.mail, event.pass);
    }else if(event is LoggedInWithGoogle){
      yield* _loggedInGoogle();
    }else if(event is LoggedOut){
      yield* _mapLoggedOutMap();
    }
  }

  Stream<AuthState> _mapAppLaunchedToMap() async*{
    try{
      final sigIn = await _repository.isAuthenticated();

      if(sigIn){
        FirebaseUser user = await _repository.getCurrentUser();
        yield Authenticated(user);
      }else{
        yield Unauthenticated();
      }
    }
    catch(_){
      yield AuthError();
    }
  }

  Stream<AuthState> _createUserMail(String mail, String pass) async*{
    FirebaseUser user;
    yield AuthInProgress();
    try{
        final isAuth = await _repository.isAuthenticated();
        if(isAuth){
          user = await _repository.getCurrentUser();
          yield Authenticated(user);
        }else{
          user = await _repository.createUserWithMail(mail, pass);
          yield Authenticated(user);
        }
      }
      catch(_){
        yield AuthError();
      }
  }

  Stream<AuthState> _loggedInGoogle() async*{
    try{
      yield AuthInProgress();
      final sigIn = await _repository.isAuthenticated();
      FirebaseUser user;
      if(sigIn){
        user = await _repository.getCurrentUser();
        yield Authenticated(user);
      }else{
        user = await _repository.signInGoogle();
        yield Authenticated(user);
      }
    }
    catch(_){
      yield AuthError();
    }

  }

  Stream<AuthState> _mapLoggedOutMap() async*{
    _repository.signOut();
    yield Unauthenticated();
  }

}