import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/logger.dart';
// import 'package:dd/features/gemini/data/data_sources/gemini_source.dart';
import 'package:dd/features/notes/domain/entities/notes_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/util/typedefs.dart';
import '../../../auth/presentation/controllers/user_id.dart';

part 'notes_controller.g.dart';

@riverpod
class NotesController extends _$NotesController {
  @override
  Stream<Iterable<Notes>> build() async* {
    final userId = await ref.watch(userIdProvider.future);

    final controller = StreamController<Iterable<Notes>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.notes)
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .snapshots()
        .listen((snaps) {
      final document = snaps.docs;
      final doc = document.where((data) => !data.metadata.hasPendingWrites);
      final notes = doc.map(
          (note) => Notes.fromDatabase(data: note.data(), notesId: note.id));
      notes.log('firestore subscricption');
      controller.add(notes);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    await for (final note in controller.stream) {
      note.log('notes');
      yield note;
    }
  }

  Future<NoteId> addNote({required String note, required String title}) async {
    final userId = await ref.watch(userIdProvider.future);

    try {
      final notePayload = NotesPayload(
        title: title,
        note: note,
        aiThoughts: '',
        userId: userId,
      );
      final notesCollection =
          FirebaseFirestore.instance.collection(FirebaseCollectionNames.notes);

      final addPayload = await notesCollection.add(notePayload);

      final noteId = addPayload.id;
      return noteId;
    } catch (e) {
      e.log();
      return '';
    }
  }

  Future<void> editNote(
      {required String title,
      required String note,
      String? aiThoughts,
      required NoteId noteId}) async {
    // final userId = ref.watch(userIdProvider.future);

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.notes)
          .doc(noteId)
          .update({
        FirebaseFieldNames.title: title,
        FirebaseFieldNames.note: note,
        FirebaseFieldNames.aiThoughts: aiThoughts
      });
    } catch (e) {
      e.log();
    }
  }

  Future<void> deleteNote({required String id}) async {}

  Future<void> generateAiThoughts({required String aiThoughts}) async {}
}
