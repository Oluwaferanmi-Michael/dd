import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/features/tasks/domain/entity/steps_entity.dart';

import '../../../../core/resources/constants/firebase_constants.dart';
import 'task_constants.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/util/typedefs.dart';

class Tasks extends Equatable {
  final Task task;
  final DateTime startDate;
  final DateTime dueDate;
  final UID userId;
  final TaskId taskId;
  final bool done;

  const Tasks(
      {required this.task,
      required this.dueDate,
      required this.startDate,
      required this.done,
      required this.userId,
      required this.taskId
      });


  Tasks.fromDatabase({
    required Map<String, dynamic> task,
    required TaskId tasksId,
  }) : 
  task = task[TaskConstants.task],
  done = task[TaskConstants.done],
  dueDate = (task[TaskConstants.dueDate] as Timestamp).toDate(),
  startDate = (task[TaskConstants.startDate] as Timestamp).toDate(),
  userId = task[FirebaseFieldNames.userId],
  taskId = tasksId;

  @override
  List<Object?> get props => [
        task,
        startDate,
        dueDate,
        done,
        userId, taskId
      ];
}

class TaskPayload extends MapView<String, dynamic> {
  TaskPayload({
    required Task task,
    required DateTime dueDate,
    required DateTime userId,
    required StepPayload step,
  }) : super({
    TaskConstants.task : task,
    TaskConstants.done : false,
    TaskConstants.startDate : FieldValue.serverTimestamp(),
    TaskConstants.dueDate : Timestamp.fromDate(dueDate),
    FirebaseFieldNames.userId : userId,
    TaskConstants.steps : step
  });
}
