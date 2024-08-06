import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/tasks/domain/entity/task_entity.dart';
import 'package:dd/features/tasks/domain/entity/task_with_steps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entity/steps_entity.dart';
import 'dart:async';

part 'task_with_steps_controller.g.dart';

@riverpod
class TaskWithStepsController extends _$TaskWithStepsController{

@override
Stream<TaskWithSteps> build({required TaskId taskId}) async* {
  final controller = StreamController<TaskWithSteps>();

  Tasks? task;
  Iterable<Steps>? steps;

  void notify() {
    final localTask = task;
    if (task == null) {
      return;
    }

    final localSteps = steps ?? [];

    final result = TaskWithSteps(task: localTask!, steps: localSteps);

    controller.add(result);
  }

  // final userId = await ref.read(userIdProvider.future);
  final taskSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.tasks)
      .where(FieldPath.documentId, isEqualTo: taskId)
      .snapshots()
      .listen((snaps) {
    if (snaps.docs.isEmpty) {
      task = null;
      steps = null;
      notify();
      return;
    } else {
      final docs = snaps.docs.first;
      if (docs.metadata.hasPendingWrites) {
        return;
      }

      task = Tasks.fromDatabase(task: docs.data(), tasksId: docs.id);

      notify();
    }
  });

  final stepsSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.steps)
      .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
      .snapshots()
      .listen((snaps) {
    final docs = snaps.docs;
    final doc = docs.where((step) => !step.metadata.hasPendingWrites);
    steps = doc
        .map((step) => Steps.fromDatabase(data: step.data(), stepsId: step.id))
        .toList();

    notify();
  });

  ref.onDispose(() {
    controller.close();
    taskSub.cancel();
    stepsSub.cancel();
  });

  await for (final taskWithStep in controller.stream) {
    yield taskWithStep;
  }
}
}