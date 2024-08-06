import 'package:dd/core/util/barrel.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/insets.dart';
import '../../core/util/typedefs.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetail extends ConsumerWidget {
  final int? index;
  final TaskId? taskId;
  const TaskDetail({this.index, this.taskId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(Insets.twelve),
        decoration: BoxDecoration(
          color: AppColors.seed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$index, title',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  )),
              Text('Steps'),
              Text('Points'),
            ]));
  }
}
