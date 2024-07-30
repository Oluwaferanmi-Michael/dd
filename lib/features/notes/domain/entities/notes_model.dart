import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/typedefs.dart';
import 'notes_constants.dart';

class Notes extends Equatable {
  final String note;
  final UID userId;
  final String? noteId;
  final String title;
  final String? aiThoughts;
  final DateTime? createdAt;

  const Notes(
      {required this.note,
      required this.title,
      this.aiThoughts,
      required this.userId,
      this.noteId,
      this.createdAt});

  Notes.fromDatabase(
      {required Map<String, dynamic> data, required String notesId})
      : title = data[NotesConstants.title],
        note = data[NotesConstants.note],
        userId = data[NotesConstants.userId],
        noteId = notesId,
        aiThoughts = data[NotesConstants.aiThoughts],
        createdAt = (data[NotesConstants.createdAt]as Timestamp).toDate();

  const Notes.unknown()
      : title = '',
        note = '',
        aiThoughts = '',
        userId = '',
        noteId = '',
        createdAt = null;

  

  Notes copyWith({
    String? aiThoughts,
    String? note,
    String? title,
  }) =>
      Notes(
          title: title ?? this.title,
          note: note ?? this.note,
          aiThoughts: aiThoughts ?? this.aiThoughts,
          userId: userId,
          createdAt: createdAt);

  @override
  List<Object?> get props => [title, note, aiThoughts, userId];
}

class NotesPayload extends MapView<String, dynamic> {
  NotesPayload({
    required String? title,
    required String note,
    required String? aiThoughts,
    required String userId,
  }) : super({
          NotesConstants.title: title,
          NotesConstants.note: note,
          NotesConstants.aiThoughts: aiThoughts,
          NotesConstants.userId: userId,
          NotesConstants.createdAt: FieldValue.serverTimestamp()
        });
}
