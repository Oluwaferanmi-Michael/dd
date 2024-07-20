import 'package:dd/config/presentation/states/empty_state.dart';
import 'package:dd/config/presentation/strings.dart';
import 'package:dd/features/notes/presentation/controller/notes_controller.dart';

import '../../core/util/barrel.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesControllerProvider);

    return Scaffold(
      body: notes.when(
          data: (data) {
            return data.isEmpty
                ? const EmptyState(
                    text: Strings.emptyState,
                    illustration: Illustrations.emptyState)
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width / 6,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black38,
                                  ),
                                ),
                                const Gap(height: 12),
                                Text(data.elementAt(index).title ?? 'Unknown'),
                                Text(
                                    data.elementAt(index).createdAt.toString()),
                              ],
                            ),
                          );
                        }),
                  );
          },
          error: (e, s) => const FlutterLogo(),
          loading: () => const LinearProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Row(
            children: [
              Icon(Icons.edit_outlined),
              Gap(
                width: 8,
              ),
              Text('Create Note', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          )),
    );
  }
}
