import 'package:dd/config/presentation/strings.dart';
import 'package:dd/core/util/ext.dart';
import 'package:flutter/material.dart';

import 'lottie_animation_view.dart';

class DDIdleAnimation extends LottieAnimationView {
  const DDIdleAnimation({super.key, required super.animation, super.repeat = true});
}


class DdIdleAnimationWidget extends StatelessWidget {
  const DdIdleAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DDIdleAnimation(
        animation: LottieStrings.dd.lottiePath(),
      )
    );
  }
}
