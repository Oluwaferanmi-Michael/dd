import 'package:dd/features/auth/presentation/controllers/authentication_controller.dart';

import 'home/home.dart';
import 'notes_pages/notes.dart';

import '../core/resources/constants/page_constants.dart';
import '../core/util/barrel.dart';
import '../core/util/controllers/bottom_nav_controller.dart';
import 'tasks_pages/tasks.dart';

class MainNavPage extends ConsumerWidget {
  const MainNavPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavControllerProvider);

    final screens = [
      const HomePage(),
      const NotesPage(),
      const TasksPage(),
      // const RelaxPage(),
    ];

    return Scaffold(
      drawer: Drawer(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {
                ref.watch(authServiceProvider.notifier).logOut();
              },
              child: const Text('log out'))
        ]),
      ),
      appBar: AppBar(
        title: const Text('DD',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            ref.read(bottomNavControllerProvider.notifier).change(value);
          },
          elevation: 4,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.amberAccent,
          unselectedItemColor: const Color(0xFF1E1E1E),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          // unselectedLabelStyle: const TextStyle(),
          iconSize: 20.0,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: PageConstants.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.notes_rounded), label: PageConstants.notes),
            BottomNavigationBarItem(
                icon: Icon(Icons.sticky_note_2_outlined),
                label: PageConstants.tasks),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.all_inclusive), label: PageConstants.relax),
          ]),
    );
  }
}
