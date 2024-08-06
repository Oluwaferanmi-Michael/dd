import 'package:dd/core/util/barrel.dart';
import 'package:dd/features/notes/domain/entities/notes_model.dart';
import 'package:dd/features/notes/presentation/controller/notes_controller.dart';
import 'package:dd/features/tasks/presentation/task_controller.dart';
import '../../../config/presentation/strings.dart';
import '../../dd_chat_screen.dart';

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
          const Expanded(
            child: NotesSummary(),
          )
        ],
      ),
    );
  }
}

class NotesSummary extends ConsumerWidget {
  const NotesSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesControllerProvider);
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  data.elementAt(index).title.trim(),
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
        ));
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
          const Expanded(
            child: TasksDaySelector(),
          ),
          const Gap(height: 12),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  const StreakComponent(),
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

class StreakComponent extends ConsumerWidget {
  const StreakComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.black12),
      child: const Column(
        children: [
          Text('Streak'),
          Text('0', style: TextStyle(fontSize: 52, fontWeight: FontWeight.w900))
        ],
      ),
    );
  }
}

class TasksDaySelector extends ConsumerWidget {
  const TasksDaySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskControllerProvider);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.black12),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black12),
              child: Column(
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Task Schedule',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('data'),
                      ]),
                  const Gap(
                    height: 12,
                  ),
                  tasks.when(
                      data: (tasks) {
                        return tasks.isEmpty
                            ? const Center(
                                child: Text('No Tasks yet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            : ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return ActionChip(
                                    label: Text('${tasks.elementAt(index)}'),
                                    onPressed: () {}
                                    );
                                });
                      },
                      error: (err, stackTrace) => const FlutterLogo(),
                      loading: () => const LinearProgressIndicator()),
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
                borderRadius: BorderRadius.circular(16), color: Colors.black12),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_outlined)),
          ),
        ),
      ],
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
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '1:30:00',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Focus Timer',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
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
            child: const UserPointsView(),
          ),
        )
      ]),
    );
  }
}

class UserPointsView extends StatelessWidget {
  const UserPointsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
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
        ]);
  }
}
