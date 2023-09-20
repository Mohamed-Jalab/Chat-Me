import 'package:chat_app/cubits/register_screen/cubit.dart';
import 'package:chat_app/cubits/register_screen/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const ChatScreen()),
                (route) => false);
          }
          if (state is RegisterErrorState) {
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
          RegisterCubit cubit = BlocProvider.of(context);
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage('images/logo.png'), height: 180),
                          const SizedBox(height: 40),
                          CutomTextField(
                            controller: cubit.usernameController,
                            onChanged: (value) {},
                            hintText: 'Enter your username',
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
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
                              if (cubit.usernameController.text != '' &&
                                  cubit.passwordController.text != '' &&
                                  cubit.emailController.text != '') {
                                cubit.registerUser();
                              } else {
                                ToastContext().init(context);
                                Toast.show('Complete all fields');
                              }
                            },
                            title: 'Register',
                            color: const Color(0xFF1565C0),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                          if (state is RegisterLoadingState)
              Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1565C0)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
