import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/util/barrel.dart';

class EditNotes extends HookConsumerWidget {
  const EditNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final noteController = useTextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.auto_awesome_outlined),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
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
    );
  }
}
