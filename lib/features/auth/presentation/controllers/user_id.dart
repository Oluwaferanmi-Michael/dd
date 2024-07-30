import 'package:dd/features/auth/presentation/controllers/authentication_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_id.g.dart';

@riverpod
Future<String> userId(Ref ref) async {
  final authState = ref.read(authServiceProvider);
  return Future.value(authState.user?.id ?? '');
  }