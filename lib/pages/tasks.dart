import '../core/util/barrel.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Text(
          'Tasks'
        )
        )
    );
  }
}