import 'package:dd/config/presentation/bottom_sheets/bottom_sheets.dart';

import 'package:dd/core/util/barrel.dart';
import 'package:dd/core/util/logger.dart';
import 'package:dd/features/focus_timer/presentation/focus_timer_controller.dart';

import 'package:dd/features/notes/presentation/controller/notes_controller.dart';

import 'package:dd/features/tasks/presentation/task_controller.dart';

import '../../../config/presentation/bottom_sheets/focus_timer_bottom_sheet.dart';
import '../../../core/util/controllers/task_select_controller.dart';

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
              'Recent notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // const Gap(
            //   height: 12,
            // ),
            Flexible(
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
                    loading: () => const LinearProgressIndicator()))
          ]),
        ));
  }
}

class SelectedTaskSummary extends ConsumerWidget {
  const SelectedTaskSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTaskId = ref.watch(taskSelectControllerProvider);
    final specificTask = ref.watch(taskControllerProvider);

    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.black12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Task Summary',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Gap(height: 16),
          selectedTaskId.isEmpty
              ? const Expanded(child: Text('No tasks yet'))
              : Flexible(
                  child: specificTask.when(
                      data: (data) {
                        final controller = PageController(
                          initialPage: 0,
                        );
                        data.log();
                        return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                        child:
                                            Text(data.elementAt(index).task)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.elementAt(index).taskStatus,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: AppColors.seed)),
                                        Text(
                                            data
                                                .elementAt(index)
                                                .dueDate
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                      ],
                                    )
                                  ]);
                            });
                      },
                      error: (error, stackTrace) => const FlutterLogo(),
                      loading: () => const LinearProgressIndicator()),
                )
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
    int? value = 0;

    final tasks = ref.watch(taskControllerProvider);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: AppColors.lightGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Task Schedule',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Gap(height: 12),
          tasks.when(
              data: (data) {
                return data.isEmpty
                    ? const Center(
                        child: Text('No Tasks yet'),
                      )
                    : Flexible(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ChoiceChip(
                                onSelected: (val) {
                                  value = val ? index : null;
                                  ref
                                      .watch(
                                          taskSelectControllerProvider.notifier)
                                      .select(data.elementAt(index).taskId);
                                },
                                selectedColor: AppColors.seed,
                                backgroundColor: AppColors.grey,
                                selected: value == index,
                                label: const Text('0'),
                              );
                            }),
                      );
              },
              error: (err, stackTrace) => const FlutterLogo(),
              loading: () => const LinearProgressIndicator()),
        ],
      ),
    );
  }
}


class TipComponent extends ConsumerWidget {
  const TipComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? value = 0;

    final tasks = ref.watch(taskControllerProvider);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: AppColors.lightGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tips on managing ADHD',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Gap(height: 12),
          tasks.when(
              data: (data) {
                final controller = PageController();
                return data.isEmpty
                    ? const Center(
                        child: Text('No Tasks yet'),
                      )
                    : Flexible(
                        child: PageView.builder(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ChoiceChip(
                                onSelected: (val) {
                                  value = val ? index : null;
                                  ref
                                      .watch(
                                          taskSelectControllerProvider.notifier)
                                      .select(data.elementAt(index).taskId);
                                },
                                selectedColor: AppColors.seed,
                                backgroundColor: AppColors.grey,
                                selected: value == index,
                                label: const Text('0'),
                              );
                            }),
                      );
              },
              error: (err, stackTrace) => const FlutterLogo(),
              loading: () => const LinearProgressIndicator()),
        ],
      ),
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

class FocusTimerComponent extends ConsumerWidget {
  const FocusTimerComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(focusTimerControllerProvider);
    return GestureDetector(
      onTap: () => FocusTimerBottomSheet().present(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              timer,
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Focus Timer',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
