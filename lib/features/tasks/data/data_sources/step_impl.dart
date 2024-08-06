import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/tasks/data/repository/step_repository.dart';
import 'package:dd/features/tasks/domain/entity/steps_entity.dart';

class StepImpl extends StepRepository {
  const StepImpl();

  @override
  Future<void> createStep(
      {required StepPayload stepPayload,
      required TaskId taskId,
      required UID userId}) async {
    try {
      final tasks = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.steps)
          .where(FirebaseFieldNames.userId, isEqualTo: userId)
          .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
          .get();

      await tasks.docs.first.reference.update(stepPayload);

    } catch (e) {
      e.log();
    }
  }

  @override
  Future<void> removeStep(
      {required TaskId taskId, required StepId stepId}) async {
    // TODO: implement removeStep
    throw UnimplementedError();
  }

  @override
  Future<void> updateStep(
      {required bool isDone, required TaskId taskId}) async {
    // TODO: implement updateStep
    throw UnimplementedError();
  }
}
