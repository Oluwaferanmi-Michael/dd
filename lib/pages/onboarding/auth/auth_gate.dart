import 'package:dd/features/auth/presentation/controllers/authentication_controller.dart';
import 'package:dd/pages/main_nav_page.dart';
import 'package:dd/pages/onboarding/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends StatelessWidget {
  const  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoggedIn = ref.watch(authServiceProvider).isLoggedIn;

    if (isLoggedIn) {
      return const MainNavPage();
    } else {
       return const SignUpScreen();
    }
      }
    );

    
  }
}