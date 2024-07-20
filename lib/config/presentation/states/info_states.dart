import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoStates extends StatelessWidget {
  final String text;
  final String illustration;

  const InfoStates({required this.text, required this.illustration, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 240,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/illustrations/$illustration',
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black26,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ])),
    );
  }
}
