import 'package:dd/features/notes/presentation/controller/notes_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/util/barrel.dart';
import '../../core/util/typedefs.dart';

class EditNotes extends HookConsumerWidget {
  final String title;
  final String note;
  final NoteId noteId;
  const EditNotes(
      {required this.title,
      required this.note,
      required this.noteId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final noteController = useTextEditingController();

    final notesNotifier = ref.watch(notesControllerProvider.notifier);

    // final notesState = useState(note);

    noteController.text = note;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }

        await notesNotifier.editNote(title: title, note: note, noteId: noteId);

        if (context.mounted) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Row(children: [
            Icon(Icons.auto_awesome_outlined),
            Gap(width: 12),
            Text('what does dd think',
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                // await notesNotifier.editNote(
                //     note: noteController.text,
                //     title: titleController.text,
                //     createdAt: createdAt
                //     );
                if (context.mounted) {
                  Navigator.pop(context, true);
                }
              },
              icon: const Icon(Icons.chevron_left_rounded)),
          title: const Text('Notes',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        ),
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 42,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    // labelText: title ?? '',
                    // labelStyle: const TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 24),
                    hintText: title.isEmpty ? 'Title' : title,
                    hintStyle: const TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
                maxLines: 2,
                onEditingComplete: () {},
                controller: titleController,
              ),
            ),
            const Gap(height: 16),
            Flexible(
                child: TextField(
              controller: noteController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Whats\'s on your mind',
                  hintStyle: TextStyle(
                      color: Colors.black26, fontStyle: FontStyle.italic)),
              minLines: null,
              maxLines: null,
              expands: true,
            ))
          ]),
        )),
      ),
    );
  }
}
