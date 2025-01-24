import 'package:dd/core/util/enums.dart';

import '../../features/chat_with_dd/domain/entities/chat_entity.dart';

extension EnumToString on MessageFrom {
  String string() => name.toString();
}

extension FullPath on String {
  String illustrationPath() => 'assets/illustrations/$this';

  String imagePath() => 'assets/images/$this';

  String lottiePath() => 'assets/lottie/$this';
}

extension Priority on TaskPriority {
  String toProperString() {
    switch (this) {
      case TaskPriority.focusNow:
        return 'Focus Now';
      case TaskPriority.forLater:
        return 'For Later';
      case TaskPriority.nextInLine:
        return 'Next in Line';
      case TaskPriority.someday:
        return 'Someday';
      case TaskPriority.whenYouCan:
        return 'When you can';
      default:
        return '';
    }
  }
}

extension Name on String {
  String toTaskToString() {
    if (this == TaskPriority.focusNow.name) {
      return TaskPriority.focusNow.toProperString();
    } else if (this == TaskPriority.forLater.name) {
      return TaskPriority.forLater.toProperString();
    } else if (this == TaskPriority.nextInLine.name) {
      return TaskPriority.nextInLine.toProperString();
    } else if (this == TaskPriority.someday.name) {
      return TaskPriority.someday.toProperString();
    } else if (this == TaskPriority.whenYouCan.name) {
      return TaskPriority.whenYouCan.toProperString();
    } else {
      return '';
    }
  }

  TaskPriority toPriorityEnum() {
    if (this == TaskPriority.focusNow.name) {
      return TaskPriority.focusNow;
    } else if (this == TaskPriority.forLater.name) {
      return TaskPriority.forLater;
    } else if (this == TaskPriority.nextInLine.name) {
      return TaskPriority.nextInLine;
    } else if (this == TaskPriority.someday.name) {
      return TaskPriority.someday;
    } else if (this == TaskPriority.whenYouCan.name) {
      return TaskPriority.whenYouCan;
    } else {
      return TaskPriority.focusNow;
    }
  }

  int toPolygonSides() {
    if (this == TaskPriority.focusNow.name) {
      return 6;
    } else if (this == TaskPriority.forLater.name) {
      return 4;
    } else if (this == TaskPriority.nextInLine.name) {
      return 4;
    } else if (this == TaskPriority.someday.name) {
      return 3;
    } else if (this == TaskPriority.whenYouCan.name) {
      return 2;
    } else {
      return 1;
    }
  }
}

extension StringToMessageFrom on String {
  MessageFrom toMessageFrom() {
    if (this == MessageFrom.ai.string()) {
      return MessageFrom.ai;
    } else {
      return MessageFrom.user;
    }
  }
}
