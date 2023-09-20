import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/logo.png'),
                width: 180,
                height: 180,
              ),
              const Text(
                'Chat Me',
                style: TextStyle(
                    color: Color(0xFF2E386B),
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: 'Sign In',
                color: const Color(0xFFF57F17),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SignInScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Register',
                color: const Color(0xFF1565C0),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
