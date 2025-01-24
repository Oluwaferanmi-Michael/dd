import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    required this.animation,
    required this.repeat,
    super.key});

  final String animation;
  final bool repeat;
  

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(animation,
    repeat: repeat,

    );
  }
}