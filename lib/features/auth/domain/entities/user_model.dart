import 'dart:collection';

import 'package:dd/core/util/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/constants/firebase_constants.dart';

class UserModel extends Equatable {
  final UID? id;
  final Email? email;
  final Username? username;
  final int? streak;
  final int? points;

  const UserModel({
    this.email,
    this.points, required this.id, this.username, this.streak});

  const UserModel.unknown()
      : id = '',
      email = '',
        username = '',
        streak = 0,
        points = 0;

  UserModel copyWithUserName({required String username}) =>
      UserModel(email: email, id: id, username: username, streak: streak, points: points);

  UserModel copyWithPoints({required int points}) =>
      UserModel(email: email,id: id, points: points);

  UserModel copyWithStreak({required int streak}) =>
      UserModel(email: email,id: id, streak: streak);

  @override
  List<Object?> get props => [id, username];
}

class UserPayload extends MapView<String, dynamic> {
  UserPayload(
      {final UID? userId,
      final String? userName,
      final int? points,
      final int? streak,
      final Email? email,
      })
      : super({
        FirebaseFieldNames.email: email,
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.userName: userName,
          FirebaseFieldNames.points: points,
          FirebaseFieldNames.streak: streak,
        });
}
