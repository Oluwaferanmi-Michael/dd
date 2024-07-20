import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/logger.dart';
// import 'package:dd/features/gemini/data/data_sources/gemini_source.dart';
import 'package:dd/features/notes/domain/entities/notes_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/user_id.dart';

part 'notes_controller.g.dart';

@riverpod
class NotesController extends _$NotesController {
  @override
  Stream<Iterable<Notes>> build() async* {
    // final userId = ref.read(userIdProvider);

    final controller = StreamController<Iterable<Notes>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseConstants.notes)
        .snapshots()
        .listen((snaps) {
      final notes = snaps.docs.map(
          (note) => Notes.fromDatabase(data: note.data(), notesId: note.id));
      notes.log('firestore subscricption');
      controller.add(notes);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    // Iterable<Chats> returnValue = [];

    await for (final note in controller.stream) {
      note.log('notes');
      yield note;
    }
  }
    // final _geminiSource = GeminiSource();

    // String _generateAiThought() {
    //   _geminiSource.
    //   return '';
    // }

    Future<void> addNote({
      required String note,
      String? title,
    }) async {
      final userId = ref.read(userIdProvider);

      final notesCollection =
          FirebaseFirestore.instance.collection(FirebaseConstants.notes);

      final notePayload = NotesPayload(
          title: title ?? '', note: note, aiThoughts: '', userId: userId);

      notesCollection.add(notePayload);
    }

    Future<void> editNote() async {}

    Future<void> deleteNote() async {}

    Future<void> generateAiThoughts() async {}
  }
