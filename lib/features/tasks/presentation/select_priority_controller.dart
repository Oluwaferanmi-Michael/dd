import 'package:dd/core/util/ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/enums.dart';

part 'select_priority_controller.g.dart';

@riverpod
class SelectPriorityController extends _$SelectPriorityController {

  @override
  String build(){
  return TaskPriority.focusNow.toProperString();
  }

  void selectPirority({required String priorityLevel}) {
    state = priorityLevel;
  }
}
