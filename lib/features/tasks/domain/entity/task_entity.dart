import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/enums.dart';

import '../../../../core/resources/constants/firebase_constants.dart';
import 'task_constants.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/util/typedefs.dart';

class Tasks extends Equatable {
  final Task task;
  final TaskDescription description;
  final Points points;
  final DateTime startDate;
  final DateTime dueDate;
  final UID userId;
  final String taskStatus;
  final String priority;
  final TaskId taskId;
  final bool done;

  const Tasks(
      {required this.task,
      required this.description,
      required this.points,
      required this.dueDate,
      required this.startDate,
      required this.taskStatus,
      required this.priority,
      required this.done,
      required this.userId,
      required this.taskId});
  //
  Tasks.none()
      : task = '',
        description = '',
        points = 0,
        startDate = DateTime.now(),
        dueDate = DateTime.now(),
        userId = '',
        priority = '',
        taskStatus = 'undefined',
        taskId = '',
        done = false;
  //
  Tasks.fromDatabase({
    required Map<String, dynamic> task,
    required TaskId tasksId,
  })  : task = task[TaskConstants.task],
        description = task[TaskConstants.description] ?? '',
        done = task[TaskConstants.done] ?? false,
        points = task[TaskConstants.points] ?? 40,
        taskStatus = task[TaskConstants.taskStatus] ?? TaskStatus.pending.name,
        priority = task[TaskConstants.priority] ?? '',
        dueDate = (task[TaskConstants.dueDate] as Timestamp).toDate() ??
            DateTime.now(),
        startDate = (task[TaskConstants.startDate] as Timestamp).toDate(),
        userId = task[FirebaseFieldNames.userId],
        taskId = tasksId;

  @override
  List<Object?> get props => [task, startDate, dueDate, done, userId, taskId];
}

class TaskPayload extends MapView<String, dynamic> {
  TaskPayload(
      {required Task task,
      required DateTime dueDate,
      required UID userId,
      required String priority,
      String? description})
      : super({
          TaskConstants.task: task,
          TaskConstants.description: description,
          TaskConstants.done: false,
          TaskConstants.points: 40,
          TaskConstants.startDate: FieldValue.serverTimestamp(),
          TaskConstants.dueDate: Timestamp.fromDate(dueDate),
          TaskConstants.taskStatus: TaskStatus.pending.name,
          TaskConstants.priority: priority,
          FirebaseFieldNames.userId: userId,
        });
}
