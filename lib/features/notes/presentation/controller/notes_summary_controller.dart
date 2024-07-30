import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/features/notes/domain/entities/notes_model.dart';

part 'notes_summary_controller.g.dart';

@riverpod
Stream<Iterable<Notes>> notesSummary(ref) async* {

  final userId = await ref.watch(userIdProvider.future);

  final controller = StreamController<Iterable<Notes>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.notes)
      .where(FirebaseFieldNames.userId, isEqualTo: userId)
      .limit(5)
      .snapshots()
      .listen((snap) {
    final doc = snap.docs;
    final documents = doc.where((data) => !data.metadata.hasPendingWrites);
    final notes = documents
        .map((note) => Notes.fromDatabase(data: note.data(), notesId: note.id));
    controller.add(notes);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  await for (final item in controller.stream) {
    yield item;
  }
}
