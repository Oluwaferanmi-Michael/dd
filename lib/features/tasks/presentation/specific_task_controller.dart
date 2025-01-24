import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/typedefs.dart';
import '../domain/entity/task_entity.dart';

part 'specific_task_controller.g.dart';

@riverpod
class SpecificTaskController extends _$SpecificTaskController {
  @override
  Stream<Iterable<Tasks>> build({required TaskId taskId}) async* {
    try {
      final controller = StreamController<Iterable<Tasks>>();

      // controller.sink.add([Tasks.none()]);

      // if (taskId.isEmpty) {
      //   await for (final task in controller.stream) {
      //     yield task;
      //   }
      // }

      final sub = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.tasks)
          .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
          .limit(1)
          .snapshots()
          .listen((snaps) {
        final snap = snaps.docs;
        final doc = snap.where((e) => !e.metadata.hasPendingWrites);
        final tasks = doc.map(
            (task) => Tasks.fromDatabase(task: task.data(), tasksId: task.id));

        controller.add(tasks);
      });

      ref.onDispose(() {
        controller.close();
        sub.cancel();
      });

      await for (final task in controller.stream) {
        yield task;
      }
    } catch (e) {
      e.log();
    }
  }
}
