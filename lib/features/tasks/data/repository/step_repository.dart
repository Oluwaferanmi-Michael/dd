import '../../../../core/util/typedefs.dart';
import '../../domain/entity/steps_entity.dart';

abstract class StepRepository {
  const StepRepository();

  Future<void> createStep({required StepPayload stepPayload, required TaskId taskId, required UID userId});

  Future<void> updateStep({
      required bool isDone,
      required TaskId taskId,
      });

  Future<void> removeStep({required TaskId taskId, required StepId stepId});
}
