import 'package:chat_app/cubits/sign_in_screen/cubit.dart';
import 'package:chat_app/cubits/sign_in_screen/states.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const ChatScreen()),
                (route) => false);
          }
          if (state is SignInErrorState) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: SizedBox(
                  height: 120,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      Text(
                        state.error,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          SignInCubit cubit = BlocProvider.of<SignInCubit>(context);
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage('images/logo.png'),
                              height: 180),
                          const SizedBox(height: 40),
                          CutomTextField(
                            controller: cubit.emailController,
                            onChanged: (value) {},
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CutomTextField(
                            controller: cubit.passwordController,
                            onChanged: (value) {},
                            hintText: 'Enter your password',
                            obscure: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            onPressed: () {
                              if (cubit.emailController.text != '' &&
                                  cubit.passwordController.text != '') {
                                cubit.signInUser();
                              } else {
                                ToastContext().init(context);
                                Toast.show('Complete all fields');
                              }
                            },
                            title: 'Sign In',
                            color: const Color(0xFFF57F17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is SignInLoadingState)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFFF57F17)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
