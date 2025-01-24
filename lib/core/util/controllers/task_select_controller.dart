import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_select_controller.g.dart';

@riverpod
class TaskSelectController extends _$TaskSelectController {
  @override
  String build() {
    return '0';
  }

  void select(String val) {
    state = val;
  }
}
