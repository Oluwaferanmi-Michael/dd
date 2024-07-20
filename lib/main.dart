import 'package:dd/core/util/barrel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // service locators
  // initializeDependencies();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
        fontFamily: 'Satoshi',
      ),
      home: const Scaffold(
        body: AuthGate(),
      ),
    );
  }
}
