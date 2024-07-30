import '../../features/chat_with_dd/domain/entities/chat_entity.dart';

extension EnumToString on MessageFrom {
  String string() => name.toString();
}

extension StringToMessageFrom on String {
  MessageFrom toMessageFrom() {
    if (this == MessageFrom.ai.string()) {
      return MessageFrom.ai;
    } else {
      return MessageFrom.user;
    }
  }
}