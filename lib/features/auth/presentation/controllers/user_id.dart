import 'package:dd/features/auth/presentation/controllers/authentication_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_id.g.dart';

@riverpod
String userId(Ref ref) {
  final authState = ref.read(authServiceProvider);
  return authState.user?.id ?? '';
  }