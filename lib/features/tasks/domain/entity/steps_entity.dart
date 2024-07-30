import 'dart:collection';

import '../../../../core/resources/constants/firebase_constants.dart';

import 'step_constants.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/typedefs.dart';

class Steps extends Equatable {
  final Step step;
  final Points points;
  final bool isDone;
  final UID userId;
  final TaskId taskId;
  final StepId stepId;

  const Steps({
    required this.step,
    required this.stepId,
    required this.points,
    required this.taskId,
    required this.userId,
    required this.isDone,
  });

  Steps.fromDatabase(
      {required Map<String, dynamic> data, required StepId stepsId})
      : step = data[StepConstants.step],
        points = data[StepConstants.points],
        userId = data[FirebaseFieldNames.userId],
        taskId = data[StepConstants.taskId],
        isDone = data[StepConstants.isDone],
        stepId = stepsId;

  @override
  List<Object?> get props => [
        step,
        points,
        taskId,
        userId,
      ];
}

class StepPayload extends MapView<String, dynamic> {
  StepPayload(
      {required Step step,
      required UID userId,
      required TaskId taskId,
      required Points points})
      : super({
          StepConstants.isDone: false,
          StepConstants.step: step,
          FirebaseFieldNames.userId: userId,
          StepConstants.points: points,
          StepConstants.taskId: taskId,
        });
}
