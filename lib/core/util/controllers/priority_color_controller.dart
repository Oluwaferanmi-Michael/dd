import 'package:dd/core/util/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/theme/app_colors.dart';

part 'priority_color_controller.g.dart';

@riverpod
class PriorityColorController extends _$PriorityColorController {
  @override
  Color build({required TaskPriority priority}) {
    switch (priority) {
      case TaskPriority.focusNow:
        return const Color(0xFFFD8A07);
      case TaskPriority.nextInLine:
        return const Color(0xFFE7AE0F);
      case TaskPriority.whenYouCan:
        return const Color(0xFF8E44AD);
      case TaskPriority.forLater:
        return const Color(0xFF2980B9);
      case TaskPriority.someday:
        return const Color(0xFF1ABC9C);
      default:
        return AppColors.seed;
    }
  }
}
