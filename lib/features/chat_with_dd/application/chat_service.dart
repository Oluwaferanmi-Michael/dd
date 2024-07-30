import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/core/util/ext.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/core/util/typedefs.dart';
import 'package:dd/features/chat_with_dd/data/data_source/chat_impl.dart.dart';
import 'package:dd/features/chat_with_dd/domain/entities/chat_entity.dart';
import 'package:dd/features/gemini/data/data_sources/gemini_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatService {
  const ChatService();

  final _geminiSource = const GeminiSource();
  final _chatImpl = const ChatImpl();

  Future<void> sendChat({
    required UID userId,
    required String message,
  }) async {
    List<Content> history = [];

    final chatHistory = await _chatImpl.chatHistory(userId: userId);

    for (final chat in chatHistory) {
      if (chat.from == MessageFrom.ai.string()) {
        history.add(Content.model([TextPart(chat.message)]));
        history.log('history.add');
      } else if (chat.from == MessageFrom.user.string()) {
        history.add(Content.text(chat.message));
      }
    }

    history.log('history');
    final result =
        await _geminiSource.chatModel(userText: message, history: history);

    final userMessage = ChatPayload(
      from: MessageFrom.user.string(),
      message: message,
      userId: userId,
    );
    final aiResponse = ChatPayload(
        from: MessageFrom.ai.string(), message: result ?? '', userId: userId);

    await FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.history)
        .add(userMessage);
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.history)
        .add(aiResponse);
  }
}
