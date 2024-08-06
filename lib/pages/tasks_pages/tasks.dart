import 'package:dd/features/tasks/presentation/task_controller.dart';
import 'package:dd/pages/home/components/components.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/presentation/bottom_sheets/bottom_sheets.dart';
import '../../config/presentation/bottom_sheets/create_tasks_bottom_sheet.dart';
import '../../config/theme/app_colors.dart';
import '../../core/util/barrel.dart';
import 'task_page_components.dart';

class TasksPage extends HookConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskController = ref.watch(taskControllerProvider);
    final taskNameController = useTextEditingController();
    final dateTimeController = useTextEditingController();
    late DateTime? dueDate = DateTime.now();
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => CreateTaskBottomSheet(
              presentation: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskNameController,
                    cursorColor: AppColors.purple,
                    decoration: const InputDecoration(
                        hintText: 'what do you want to do ?',
                        labelText: 'Task'),
                  ),
                  const Gap(
                    height: 24,
                  ),
                  TextField(
                    controller: dateTimeController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(3000));

                      if (picked != null) {
                        dateTimeController.text =
                            picked.toString().split(' ')[0];
                        dueDate = picked;
                      }
                    },
                    cursorColor: AppColors.purple,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        hintText: 'task deadline',
                        labelText: 'End date'),
                  )
                ],
              ),
              buttons: [
                ButtonOptions(
                    text: 'Create',
                    onPressed: () async {
                      if (dueDate == null) {
                        return;
                      }
                      await ref
                          .watch(taskControllerProvider.notifier)
                          .createTask(
                              task: taskNameController.text, dueDate: dueDate!);
                      taskNameController.clear;
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    })
              ])
            ..present(context),
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
                            'data',
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
                    Expanded(
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
                            'data',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'data',
                              style: TextStyle(
                                  fontSize: 42, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              const Gap(
                height: 24,
              ),
              const TasksDaySelector(),
              const Gap(
                height: 12,
              ),
              Flexible(
                child: TaskDetail(),
              ),
              const Gap(height: 64)
            ])));
  }
}
