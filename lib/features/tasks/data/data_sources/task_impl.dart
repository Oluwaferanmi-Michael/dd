import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/tasks/domain/entity/task_entity.dart';

import '../../../../core/resources/constants/firebase_constants.dart';
import '../repository/task_repository.dart';

class TaskImpl extends TaskRepository {
  const TaskImpl();

  @override
  Future<void> createTask(
      {required TaskPayload taskPayload}) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.tasks)
          .add(taskPayload);
    } catch (e) {
      e.log();
    }
  }

  @override
  Future<void> removeTask({required TaskId taskId, required UID userId}) async {
    try {
      final task = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.tasks)
          .where(FirebaseFieldNames.userId, isEqualTo: userId)
          .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
          .limit(1)
          .get();

      if (!task.docs.first.exists) {
        return;
      }

      await task.docs.first.reference.delete();
    } catch (e) {
      e.log();
    }
  }

  @override
  Future<void> updateTask(
      {required Map<String, dynamic> updateParameters,
      required bool isDone,
      required TaskId taskId,
      required UID userId}) async {
    try {
      final task = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.tasks)
          .where(FirebaseFieldNames.userId, isEqualTo: userId)
          .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
          .limit(1)
          .get();

      if (!task.docs.first.exists) {
        return;
      }

      await task.docs.first.reference.update(updateParameters);
    } catch (e) {
      e.log();
    }
  }
}
