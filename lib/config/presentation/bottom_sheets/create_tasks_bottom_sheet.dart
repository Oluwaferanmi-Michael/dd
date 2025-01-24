import 'package:dd/core/util/enums.dart';
import 'package:dd/core/util/ext.dart';
// import 'package:dd/core/util/logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/util/barrel.dart';
import '../../../features/tasks/presentation/select_priority_controller.dart';
import '../../../features/tasks/presentation/task_controller.dart';

import 'bottom_sheets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateTaskBottomSheet extends BottomSheetModel {
  CreateTaskBottomSheet({
    super.presentation = const TasksBottomSheetPresentation(),
    super.title = 'Create Task',
  });
}

class TasksBottomSheetPresentation extends HookConsumerWidget {
  const TasksBottomSheetPresentation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNameController = useTextEditingController();
    final dateTimeController = useTextEditingController();
    final taskDescriptionController = useTextEditingController();
    final priorityController = useTextEditingController();

    final priority = ref.watch(selectPriorityControllerProvider);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskNameController,
            cursorColor: AppColors.purple,
            decoration: AppTheme.taskInputDecoration,
          ),
          const Gap(
            height: 24,
          ),
          TextField(
            controller: taskDescriptionController,
            cursorColor: AppColors.purple,
            decoration: AppTheme.inputDecoration(
              label: 'Description (optional)',
              hint: 'say in your own words what the task is about',
            ),
          ),
          const Gap(
            height: 24,
          ),
          DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              helperText: 'How importanat is the task?',
              controller: priorityController,
              trailingIcon: const Icon(Icons.arrow_drop_down_rounded),
              selectedTrailingIcon: const Icon(Icons.arrow_drop_up_rounded),
              inputDecorationTheme: AppTheme.dropDownInputDecoration,
              // width: MediaQuery.sizeOf(context).width - 32,
              onSelected: (newSelection) {
                ref
                    .watch(selectPriorityControllerProvider.notifier)
                    .selectPirority(
                        priorityLevel: newSelection ??
                            TaskPriority.focusNow.toProperString());
              },
              dropdownMenuEntries: TaskPriority.values
                  .map((priority) => DropdownMenuEntry(
                      value: priority.name, label: priority.toProperString()))
                  .toList()),
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
                dateTimeController.text = picked.toString().split(' ')[0];
              }
            },
            cursorColor: AppColors.purple,
            decoration: AppTheme.dateInputDecoration,
          ),
          const Gap(height: 24),
          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(width: 1)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Gap(width: 12),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: AppColors.seed),
                    onPressed: () async {
                      await ref
                          .watch(taskControllerProvider.notifier)
                          .createTask(
                              priority: priority,
                              task: taskNameController.text,
                              dueDate: DateTime.parse(dateTimeController.text));
                      taskNameController.clear;
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Create task',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ])
        ]);
  }
}
