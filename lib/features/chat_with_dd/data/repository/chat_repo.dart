import 'package:dd/features/chat_with_dd/domain/entities/chat_entity.dart';

import '../../../../core/util/typedefs.dart';

abstract class ChatRepo {
  const ChatRepo();

  Future<Iterable<Chats>> chatHistory({required UID userId});

  Future<void> sendChat({required ChatPayload payload});
}
