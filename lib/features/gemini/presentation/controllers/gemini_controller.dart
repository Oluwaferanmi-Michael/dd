import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/ext.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/features/auth/presentation/controllers/user_id.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../data/data_sources/gemini_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/chat_type.dart';

part 'gemini_controller.g.dart';

@riverpod
class GeminiController extends _$GeminiController {

@override
  Stream<Iterable<Chats>> build() async* {
    // final userId = ref.read(userIdProvider);

    final controller = StreamController<Iterable<Chats>>();

    final sub = FirebaseFirestore.instance.collection(FirebaseConstants.history)
    // .orderBy(FirebaseConstants.timeStamp, descending: true)
    // .where(FirebaseConstants.userId, isEqualTo: userId)
    .snapshots().listen((snaps) {
      final chatHistory = snaps.docs.map((chat) => Chats.fromDatabase(chatData: chat.data(), chatId: chat.id));
      chatHistory.log('chat firestore subscricption');
      controller.add(chatHistory);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    // Iterable<Chats> returnValue = [];

    await for(final chat in controller.stream) {
      chat.log('stream chat');
      yield chat;
    }
}

final _gemini = const GeminiSource();


Future<String> getGeminiResponse ({
  required String prompt
}) async {

  final userId = ref.read(userIdProvider);

  List<Content> history = [];

  final value = await FirebaseFirestore.instance.collection(FirebaseConstants.history).get();

    final chatHistory = value.docs
      .where((values) => !values.metadata.hasPendingWrites)
      .map((chat) => Chats.fromDatabase(chatData: chat.data(), chatId: chat.id));

    chatHistory.log('Chat history from firestore');

    
    for (final chat in chatHistory) {
      if (chat.from == MessageFrom.ai.string()) {
        history.add(Content.model([TextPart(chat.message)]));
        history.log('history.add');
      } else if (chat.from == MessageFrom.user.string()) {
        history.add(Content.text(chat.message));
      }
    }

    history.log('chat controller history');

  final result = await _gemini.chatModel(userText: prompt, history: history);

  final userMessage = ChatPayload(from: MessageFrom.user.string(), message: prompt, userId: userId, );
  final aiResponse = ChatPayload(from: MessageFrom.ai.string(),  message: result ?? '', userId: userId);

  await FirebaseFirestore.instance.collection(FirebaseConstants.history).add(userMessage);
  await FirebaseFirestore.instance.collection(FirebaseConstants.history).add(aiResponse);
  
  return result ?? '';
}
}