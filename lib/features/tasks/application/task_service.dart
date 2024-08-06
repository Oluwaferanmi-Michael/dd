import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/tasks/data/data_sources/step_impl.dart';
import 'package:dd/features/gemini/data/data_sources/gemini_source.dart';
import 'package:dd/features/tasks/data/data_sources/task_impl.dart';
import 'package:dd/features/tasks/domain/entity/task_entity.dart';

import '../domain/entity/steps_entity.dart';

class TaskService {
  final _gemini = const GeminiSource();
  final _step = const StepImpl();
  final _task = const TaskImpl();


  Future<void> createTask({
    required TaskPayload taskPayload
  }) async {
   await _task.createTask(taskPayload: taskPayload);
  }

  // Future<void> createSteps({
  //   required TaskId taskId,
  //   required StepId stepId,
  //   required UID userId,
  // }) async {
    
  //   final step = _gemini.createSteps(task: task);

  //   await _step.createStep(
  //       taskId: taskId, userId: userId, stepPayload: StepPayload(
  //         step: ,
  //         userId: userId,
  //         points: ,
  //         taskId: ,
  //       ));
  // }
}
