import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:dd/features/chat_with_dd/domain/entities/chat_entity.dart';
import '../../../../core/util/typedefs.dart';
import '../repository/chat_repo.dart';

class ChatImpl extends ChatRepo {
  const ChatImpl();

  @override
  Future<Iterable<Chats>> chatHistory({required UID userId}) async {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.history)
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .orderBy(FirebaseFieldNames.timestamp, descending: true)
        .get();

    final chats = query.docs
        .where((value) => !value.metadata.hasPendingWrites)
        .map((chat) =>
            Chats.fromDatabase(chatId: chat.id, chatData: chat.data()));

    return chats;
  }

  @override
  Future<void> sendChat({required ChatPayload payload}) async {

    await FirebaseFirestore.instance.collection(FirebaseCollectionNames.history).add(payload);
    
  }
}
