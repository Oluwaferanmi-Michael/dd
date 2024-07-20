

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/logger.dart';

import '../../../../../core/resources/constants/firebase_constants.dart';
import '../../../../../core/util/barrel.dart';
// import '../../../../auth/presentation/controllers/user_id.dart';
import '../../../domain/entities/chat_type.dart';

final geminiChatProvider = StreamProvider<Iterable<Chats>>((ref) {

// final userId = ref.read(userIdProvider);

    final controller = StreamController<Iterable<Chats>>();

    final sub = FirebaseFirestore.instance.collection(FirebaseConstants.history)
    // .where(FirebaseConstants.userId, isEqualTo: userId)
    // .orderBy(FirebaseConstants.timeStamp, descending: true)
    .snapshots()
    .listen(
      (snaps) {
        final document = snaps.docs;
      final chatHistory = document.
      where((values) =>
        !values.metadata.hasPendingWrites
      )
      .map((chat) => Chats.fromDatabase(chatData: chat.data(), chatId: chat.id));
      chatHistory.log('firestore subscription');
      controller.add(chatHistory);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    // Iterable<Chats> returnValue = [];

  return controller.stream;
});