import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/features/auth/presentation/controllers/user_id.dart';
import 'package:dd/features/chat_with_dd/application/chat_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/resources/constants/firebase_constants.dart';

import '../domain/entities/chat_entity.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  Stream<Iterable<Chats>> build() async* {
    final userId = await ref.read(userIdProvider.future);
    userId.log('userId');

    final controller = StreamController<Iterable<Chats>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.history)
        .orderBy(FirebaseFieldNames.timestamp, descending: true)
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .snapshots()
        .listen((snaps) {
      final documents = snaps.docs;
      final docs = documents.where((e) => !e.metadata.hasPendingWrites);
      final chatHistory = docs.map(
          (chat) => Chats.fromDatabase(chatData: chat.data(), chatId: chat.id));
      chatHistory.log('chat firestore subscricption');
      controller.add(chatHistory);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    // Iterable<Chats> returnValue = [];

    await for (final chat in controller.stream) {
      chat.log('stream chat');
      yield chat;
    }
  }

  final _chatService = const ChatService();

  Future<void> chat({required String message}) async {
    final userId = await ref.watch(userIdProvider.future);
    await _chatService.sendChat(userId: userId, message: message);
  }
}
