import '../../../../core/util/typedefs.dart';

abstract class SaveUserRepo {
  const SaveUserRepo();

  Future<bool> saveUser({
    required UID userId,
    String? userName,
    required Email email
  });
}
