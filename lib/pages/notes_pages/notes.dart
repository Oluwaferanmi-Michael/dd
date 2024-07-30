import 'package:dd/config/presentation/states/empty_state.dart';
import 'package:dd/config/presentation/strings.dart';
import 'package:dd/features/notes/presentation/controller/notes_controller.dart';
import 'package:dd/pages/notes_pages/edit_notes_page.dart';

import '../../config/theme/app_colors.dart';
import '../../core/util/barrel.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesControllerProvider);
    if (!context.mounted) {
      return Scaffold(
          body: Center(
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .2,
                  child: const LinearProgressIndicator())));
    }

    return Scaffold(
      body: notes.when(
          data: (data) {
            return data.isEmpty
                ? const EmptyState(
                    text: Strings.emptyState,
                    illustration: Illustrations.emptyState)
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(notesControllerProvider);
                        Future.delayed(const Duration(seconds: 1));
                      },
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisExtent:
                                MediaQuery.sizeOf(context).height * .2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditNotes(
                                    title: data.elementAt(index).title,
                                    note: data.elementAt(index).note,
                                    noteId: data.elementAt(index).noteId ?? '');
                              })),
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * .3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    const Gap(height: 12),
                                    Text(
                                      data.elementAt(index).title.isEmpty
                                          ? 'Unknown'
                                          : data.elementAt(index).title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data
                                          .elementAt(index)
                                          .createdAt
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 8, color: AppColors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
          },
          error: (e, s) => const FlutterLogo(),
          loading: () => const LinearProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final noteId = await ref
                .watch(notesControllerProvider.notifier)
                .addNote(note: '', title: '');

            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditNotes(title: '', note: '', noteId: noteId)));
            }
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
