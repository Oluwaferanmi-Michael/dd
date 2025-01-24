import 'package:dd/config/presentation/bottom_sheets/focus_timer_bottom_sheet.dart';
import 'package:dd/features/focus_timer/presentation/focus_timer_controller.dart';
import 'package:dd/features/tasks/presentation/task_controller.dart';
import 'package:dd/pages/home/components/components.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/presentation/bottom_sheets/bottom_sheets.dart';
import '../../config/presentation/bottom_sheets/create_tasks_bottom_sheet.dart';

import '../../core/util/barrel.dart';

import 'task_page_components.dart';

class TasksPage extends HookConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskControllerProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => CreateTaskBottomSheet().present(context),
          label: const Row(children: [
            Icon(Icons.note_add_outlined),
            Gap(width: 12),
            Text('Create tasks', style: TextStyle(fontWeight: FontWeight.bold))
          ]),
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 6 - 20,
                // width: MediaQuery.sizeOf(context).width,
                // color: Colors.green,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black26,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tips',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'data',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )),
                    const Gap(
                      width: 12,
                    ),
                    const Expanded(child: FocusTimerCard()),
                  ],
                ),
              ),
              const Gap(
                height: 24,
              ),
              tasks.when(
                  data: (data) {
                    return Flexible(
                      child: Column(
                        children: [
                          const Flexible(flex: 1, child: TasksDaySelector()),
                          const Gap(
                            height: 12,
                          ),
                          Flexible(
                            flex: 4,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: PageView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return TaskDetail(
                                        tasks: data, index: index);
                                  }),
                            ),
                          ),
                          // const Gap(height: 52)
                        ],
                      ),
                    );
                  },
                  error: (error, stackTrace) => const FlutterLogo(),
                  loading: () => const LinearProgressIndicator()),
              const Gap(
                height: 12,
              ),
            ])));
  }
}

class FocusTimerCard extends ConsumerWidget {
  const FocusTimerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(focusTimerControllerProvider);
    return GestureDetector(
      onTap: () => FocusTimerBottomSheet().present(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Focus Timer',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Gap(height: 10),
            Container(
              alignment: Alignment.center,
              child: Text(
                timer,
                style:
                    const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
