import 'package:dd/features/auth/domain/entities/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationStateRepository extends Equatable {
  final UserModel? user;
  final bool isLoggedIn;
  final String? error;

  const AuthenticationStateRepository({
    this.user,
    this.isLoggedIn = false,
    this.error
  });
}

class AuthStateSuccess extends AuthenticationStateRepository {
  const AuthStateSuccess({
    super.user,
    super.isLoggedIn,
  });
  
  @override
  List<Object?> get props => [user, isLoggedIn];
}

class AuthStateError extends AuthenticationStateRepository{
  const AuthStateError({
    super.error
  });
  
  @override
  List<Object?> get props => [error];
}

class AuthStateLoading extends AuthenticationStateRepository {
  const AuthStateLoading();
  
  @override
  List<Object?> get props => [];
}

class AuthStateUnknown extends AuthenticationStateRepository {
  const AuthStateUnknown({
    super.user,
    super.isLoggedIn,
  });
  
  @override
  List<Object?> get props => [user, isLoggedIn];
}

