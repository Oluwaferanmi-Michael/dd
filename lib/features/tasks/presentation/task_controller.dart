import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/enums.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/features/tasks/application/task_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/features/auth/presentation/controllers/user_id.dart';
import 'package:dd/features/tasks/domain/entity/task_entity.dart';

import '../../../core/util/typedefs.dart';

part 'task_controller.g.dart';

@riverpod
class TaskController extends _$TaskController {
  @override
  Stream<Iterable<Tasks>> build() async* {
    final controller = StreamController<Iterable<Tasks>>();

    final userId = await ref.read(userIdProvider.future);
    final taskSub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.tasks)
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .snapshots()
        .listen((snaps) {
      final doc = snaps.docs;
      final tasks = doc.where((data) => !data.metadata.hasPendingWrites);

      final task =
          tasks.map((e) => Tasks.fromDatabase(task: e.data(), tasksId: e.id));

      controller.add(task);
    });

    ref.onDispose(() {
      controller.close();
      taskSub.cancel();
    });

    await for (final task in controller.stream) {
      yield task;
    }
  }

  final _taskService = TaskService();

  Future<void> createTask(
      {required Task task, required DateTime dueDate, required String priority}) async {
    final userId = await ref.read(userIdProvider.future);
    final taskPayload =
        TaskPayload(task: task, dueDate: dueDate, userId: userId, priority: priority);
    taskPayload.log();
    await _taskService.createTask(taskPayload: taskPayload);
  }
}
