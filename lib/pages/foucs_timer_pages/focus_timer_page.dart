import 'package:dd/features/focus_timer/presentation/focus_timer_controller.dart';

import '../../core/util/barrel.dart';

class FocusTimerPage extends ConsumerWidget {
  const FocusTimerPage({super.key, required this.timerDuration});
  final Duration timerDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(focusTimerControllerProvider);
    return PopScope(
      canPop: true,
      onPopInvoked: (isPopped) {
        final timer = ref.watch(focusTimerControllerProvider.notifier).timer;

        if (timer != null) {
          if (timer.isActive) {
            timer.cancel();
          }
        }
      },
      child: Scaffold(
          body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timer,
              style: const TextStyle(fontSize: 92, fontWeight: FontWeight.w900),
            ),
            TextButton(
              onPressed: () {
                ref
                    .watch(focusTimerControllerProvider.notifier)
                    .startTimer(time: timerDuration);
              },
              child: const Text('Start'),
            )
          ],
        ),
      )),
    );
  }
}
