// import 'package:dd/features/auth/application/authentication_service.dart';
// import 'package:dd/features/auth/data/repository/auth_repository_impl.dart';
// import 'package:dd/features/auth/domain/repository/auth_repository.dart';
// import 'package:dd/features/auth/domain/usecase/authentication.dart';
// import 'package:get_it/get_it.dart';

// final sl = GetIt.instance;


// Future<void> initializeDependencies() async {

//   //authentication repository
//   sl.registerSingleton<AuthenticationRepository>(AuthRepositoryImpl(sl())); 

//   // auth service
//   sl.registerSingleton<AuthenticationService>(sl());

//   // usecases
//   sl.registerSingleton<LogOutUseCase>(LogOutUseCase(sl()));
//   sl.registerSingleton<SignInWithEmailUseCase>(SignInWithEmailUseCase(sl()));
//   sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase(sl()));
  
// }

