import 'package:dd/features/tasks/domain/entity/steps_entity.dart';
import 'package:dd/features/tasks/domain/entity/task_entity.dart';
import 'package:equatable/equatable.dart';

class TaskWithSteps extends Equatable {
  final Tasks task;
  final Iterable<Steps> steps;

  const TaskWithSteps({
    required this.task,
    required this.steps
  });
  
  @override
  List<Object> get props => [task,
steps];
}
