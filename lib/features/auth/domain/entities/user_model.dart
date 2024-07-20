import 'package:dd/core/util/typedefs.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  
  final UID? id;
  final Username? username;
  final int? streak;

  const UserModel({
    
    required this.id,
    this.username,
    this.streak
  });

  const UserModel.unknown() : id = '', username = '', streak = 0;

  UserModel copyWithUserName({
    required String username
  }) => UserModel(id: id,username: username, streak: streak);

  UserModel copyWithStreak({
    required int streak
  }) => UserModel(id: id, streak: streak);
  
  @override
  List<Object?> get props => [ id, username];
}