import '../../../../core/util/typedefs.dart';
import '../../domain/entity/task_entity.dart';

abstract class TaskRepository {
  const TaskRepository();

  Future<void> createTask({required TaskPayload taskPayload});

  Future<void> updateTask(
      {required Map<String, dynamic> updateParameters,
      required bool isDone,
      required TaskId taskId,
      required UID userId});

  Future<void> removeTask({required TaskId taskId, required UID userId});
}
