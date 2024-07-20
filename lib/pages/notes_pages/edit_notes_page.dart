import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/util/barrel.dart';

class EditNotes extends ConsumerWidget {
  const EditNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final noteController = useTextEditingController();

    return Scaffold(
      
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.auto_awesome_outlined),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: TextField(
                expands: true,
                onEditingComplete: () {},
                controller: titleController,
                
                )),
            Flexible(child: TextField(controller: noteController,))
            ]),
        )
      ),
    );
  }
}
