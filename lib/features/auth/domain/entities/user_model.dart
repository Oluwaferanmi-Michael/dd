import 'package:dd/core/util/typedefs.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final UID? id;
  final Username? username;
  final int? streak;
  final int? points;

  const UserModel({this.points, required this.id, this.username, this.streak});

  const UserModel.unknown()
      : id = '',
        username = '',
        streak = 0, points = 0;

  UserModel copyWithUserName({required String username}) =>
      UserModel(id: id, username: username, streak: streak, points: points);

  UserModel copyWithPoints({required int points}) =>
      UserModel(id: id, points: points);

  UserModel copyWithStreak({required int streak}) =>
      UserModel(id: id, streak: streak);

  @override
  List<Object?> get props => [id, username];
}
