import 'package:dd/core/resources/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/features/auth/data/repository/save_user_repo.dart';
import 'package:dd/features/auth/domain/entities/user_model.dart';

import '../../../../core/util/typedefs.dart';

class SaveUserImpl extends SaveUserRepo {
  const SaveUserImpl();

  @override
  Future<bool> saveUser(
      {required UID userId, String? userName, required Email email}) async {
    try {
      final userRef = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.users)
          .where(FirebaseFieldNames.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userRef.docs.isNotEmpty) {
        await userRef.docs.first.reference.update({
          FirebaseFieldNames.userName: userName,
        });
      }

      final payload = UserPayload(
        userId: userId,
        userName: userName,
        streak: 0,
        points: 0,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.users)
          .add(payload);

      return true;
    } catch (e) {
      false.log();
      return false;
    }
  }
}
