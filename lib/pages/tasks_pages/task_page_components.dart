import 'package:dd/core/util/barrel.dart';
import 'package:dd/core/util/ext.dart';

import '../../config/presentation/painter/polygon_painter.dart';
import '../../core/util/controllers/priority_color_controller.dart';
import '../../features/tasks/domain/entity/task_entity.dart';

import '../../features/tasks/presentation/steps_controller.dart';

class TaskDetail extends ConsumerWidget {
  final int index;
  final Iterable<Tasks> tasks;

  const TaskDetail({required this.index, required this.tasks, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref
        .watch(stepsControllerProvider(taskId: tasks.elementAt(index).taskId));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${index + 1}. ${tasks.elementAt(index).task}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                    const Gap(height: 4),
                    const Text('description',
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                  ],
                ),
                const Gap(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: TaskInfoColumn(
                          title: 'Points',
                          body: Text('${tasks.elementAt(index).points}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                          child: TaskInfoColumn(
                        body: Text(tasks.elementAt(index).taskStatus,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        title: 'Status',
                      )),
                      SizedBox(
                        child: TaskInfoColumn(
                          title: 'Priority',
                          body: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriorityShape(
                                sides: tasks
                                    .elementAt(index)
                                    .priority
                                    .toPolygonSides(),
                                color: ref.watch(
                                    priorityColorControllerProvider(
                                        priority: tasks
                                            .elementAt(index)
                                            .priority
                                            .toPriorityEnum())),
                              ),
                              const Gap(
                                width: 4,
                              ),
                              Text(
                                  tasks
                                      .elementAt(index)
                                      .priority
                                      .toTaskToString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Gap(height: 24),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Steps',
                      style: TextStyle(color: AppColors.black),
                    ),
                    const Gap(
                      height: 12,
                    ),
                    Expanded(
                      child: steps.when(
                          data: (steps) {
                            return steps.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                            'There are currently no steps for this task'),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  side: const BorderSide(
                                                      width: 1)),
                                            ),
                                            onPressed: () {},
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons
                                                    .auto_awesome_outlined),
                                                Gap(
                                                  width: 12,
                                                ),
                                                Text(
                                                  'Create Steps',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        onChanged: (change) {},
                                        value: steps.elementAt(index).isDone,
                                        title:
                                            Text(steps.elementAt(index).step),
                                        checkColor: AppColors.purple,
                                      );
                                    });
                          },
                          error: (error, stackTrace) => const FlutterLogo(),
                          loading: () => const LinearProgressIndicator()),
                    )
                  ],
                ),
              ),
            ),
            const Gap(height: 24),
            Text('${tasks.elementAt(index).dueDate}'),
          ]),
    );
  }
}

class TaskInfoColumn extends StatelessWidget {
  const TaskInfoColumn({
    super.key,
    required this.body,
    required this.title,
  });

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.black,
            )),
        const Gap(
          height: 2,
        ),
        body,
      ],
    );
  }
}
