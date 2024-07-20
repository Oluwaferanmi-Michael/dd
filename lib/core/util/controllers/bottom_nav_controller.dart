

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bottom_nav_controller.g.dart';

@riverpod
class BottomNavController extends _$BottomNavController {

@override
int build() {
  return 0;
}

void change(int value) {
 state = value;
}}