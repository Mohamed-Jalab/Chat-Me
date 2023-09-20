import 'package:chat_app/cubits/sign_in_screen/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signInUser() async {
    try {
      emit(SignInLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) => print('Done!'));

      // if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      //   emit(SignInErrorState('please verify your email'));
      //   print('please verify your email');
      // }
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (error) {
      emit(SignInErrorState(error.code));
    } catch (error) {
      emit(SignInErrorState(error.toString()));
    }
  }
}
