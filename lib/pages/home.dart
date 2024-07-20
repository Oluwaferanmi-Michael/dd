import 'package:dd/core/util/barrel.dart';
import 'package:dd/features/notes/presentation/controller/notes_controller.dart';
import 'package:dd/pages/dd_chat_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/presentation/strings.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    return const SizedBox(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          // height: MediaQuery.sizeOf(context).height,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(children: [
            Section1(),
            Gap(
              height: 12,
            ),
            Section2(),
            Gap(
              height: 12,
            ),
            Section3()
          ]),
        ),
      ),
    ));
  }
}

class Section1 extends ConsumerWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesControllerProvider);
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height / 3) - 20,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChatWithDDScreen())),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/illustrations/${Illustrations.dd}',
                            width: 42,
                          ),
                          const Gap(
                            height: 16,
                          ),
                          const Text(
                            'Chat with DD',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                  )),
            ),
          ),
          const Gap(
            width: 12,
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notes',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Gap(
                          height: 12,
                        ),
                        Flexible(
                            child: SizedBox(
                          child: Center(
                            child: notes.when(
                                data: (data) {
                                  return data.isEmpty
                                      ? const Text(
                                          'No New Notes',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (context, index) {
                                          return Text(
                                            data.elementAt(index).title ??
                                                'Unknown',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          );
                                        });
                                },
                                error: (e, s) => const FlutterLogo(),
                                loading: () => const LinearProgressIndicator()),
                          ),
                        ))
                      ]),
                )),
          )
        ],
      ),
    );
  }
}

class Section2 extends ConsumerWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // color: Colors.purple[300],
      height: (MediaQuery.sizeOf(context).height / 3) - 20,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black12),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_left_outlined)),
                  ),
                ),
                const Gap(
                  width: 12,
                ),
                Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black12),
                      child: Column(
                        children: [
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Weekly Schedule'),
                                Text('data'),
                              ]),
                          const Gap(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...['mon', 'tue', 'wed', 'thur', 'fri']
                                  .map((e) => Text(e))
                            ],
                          )
                        ],
                      ),
                    )),
                const Gap(
                  width: 12,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black12),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right_outlined)),
                  ),
                ),
              ],
            ),
          ),
          const Gap(height: 12),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.black12),
                    child: const Column(
                      children: [
                        Text('Streak'),
                        Text('0',
                            style: TextStyle(
                                fontSize: 52, fontWeight: FontWeight.w900))
                      ],
                    ),
                  ),
                  const Gap(
                    width: 12,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.black12),
                  ))
                ],
              ))
        ],
      ),
    );
  }
}

class Section3 extends ConsumerWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height / 3) - 100,
      // color: Colors.green,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '1:30:00',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Gap(height: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Instant Meditation',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.all_inclusive_outlined)
                      ]),
                ),
              )
            ],
          ),
        ),
        const Gap(width: 12),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '0',
                    style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'Unranked',
                    style: TextStyle(fontSize: 12, color: Colors.black12),
                  ),
                ]),
          ),
        )
      ]),
    );
  }
}
