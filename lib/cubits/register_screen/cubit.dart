import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    emit(RegisterLoadingState());
    UserModel model = UserModel(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      // create an email with password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // here send the verification
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      // store the data of email in users collection
      await FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .add(model)
          .then((value) => print('Done!'));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (error) {
      emit(RegisterErrorState(error.code));
    } catch (error) {
      print(error);
    }
  }
}
