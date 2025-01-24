import 'dart:async';

import 'package:dd/core/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_timer_controller.g.dart';

@riverpod
class FocusTimerController extends _$FocusTimerController {
  @override
  String build() {
    ref.onDispose(() {
      if (timer != null) {
        if (timer!.isActive) {
          timer!.cancel();
        }
      }
    });

    return '1:30:00';
  }

  Future<void> setTimer({
    required String hour,
    required String minute,
    required String second,
  }) async {
    final isMinuteValid = _checkValidity(minute);
    final isSecondValid = _checkValidity(second);

    if (!isSecondValid || !isMinuteValid) {
      return;
    }

    final displayedValue = '$hour:$minute:$second';

    state = displayedValue;
  }

  Timer? timer;

  void startTimer({required Duration time}) {
    const oneSec = Duration(seconds: 1);

    int timeInSeconds = time.inSeconds;
    int seconds = timeInSeconds;

    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (timeInSeconds <= 0) {
          timer.cancel();
        } else {
          seconds.log();
          seconds--;
          final newSeconds = (seconds % 60).floor().toString();
          final newMinutes = ((seconds % 3600) / 60).floor().toString();
          final newHour = (seconds / 3600).floor().toString();

          state = '$newHour:$newMinutes:$newSeconds';
        }
      },
    );
  }

  bool _checkValidity(String value) {
    value.isEmpty ? value = '0' : value;

    final integerValue = int.parse(value);

    if (integerValue > 60) {
      return false;
    } else {
      return true;
    }
  }
}
