import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/resources/constants/message_constants.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/util/typedefs.dart';

enum MessageFrom {
  ai,
  user
}

class Chats extends Equatable {
  // final Map<String, dynamic> chatData;
  final String from;
  final String message;
  final DateTime timeStamp;
  final String chatId;
  final UID userId;

  const Chats({
    required this.from,
    required this.message,
    required this.timeStamp,
    required this.userId,
    required this.chatId
  });

  Chats.fromDatabase({
    required this.chatId,
    required Map<String, dynamic> chatData,
  })  :
      message = chatData[MessageConstants.message],
    userId = chatData[MessageConstants.userId],
    timeStamp = (chatData[MessageConstants.timeStamp] as Timestamp).toDate(),
    from = chatData[MessageConstants.from];
    
      @override
      List<Object?> get props => [from,
message,
timeStamp,
chatId,
userId];

@override
String toString() => 'from: message: timeStamp: chatId: userId:';
}

class ChatPayload extends MapView<String, dynamic> {

  ChatPayload({
    required String from,
    required String message,
    required UID userId,
    
  }) : super({
    MessageConstants.from : from,
    MessageConstants.message : message,
    MessageConstants.userId : userId,
    MessageConstants.timeStamp : FieldValue.serverTimestamp(),   
  });

}