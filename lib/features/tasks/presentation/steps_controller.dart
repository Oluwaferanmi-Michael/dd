import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/typedefs.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entity/steps_entity.dart';
import 'dart:async';

part 'steps_controller.g.dart';

@riverpod
class StepsController extends _$StepsController {
  @override
  Stream<Iterable<Steps>> build({required TaskId taskId}) async* {
    final controller = StreamController<Iterable<Steps>>();

    final stepsSub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.steps)
        .where(FirebaseFieldNames.taskId, isEqualTo: taskId)
        .snapshots()
        .listen((snaps) {
      final docs = snaps.docs;
      final doc = docs.where((step) => !step.metadata.hasPendingWrites);
      final steps = doc
          .map(
              (step) => Steps.fromDatabase(data: step.data(), stepsId: step.id))
          .toList();

      controller.sink.add(steps);
    });

    ref.onDispose(() {
      controller.close();
      stepsSub.cancel();
    });

    await for (final taskWithStep in controller.stream) {
      yield taskWithStep;
    }
  }

  Future<void> createSteps() async {}
}
