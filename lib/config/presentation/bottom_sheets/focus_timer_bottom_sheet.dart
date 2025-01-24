import 'package:dd/config/presentation/bottom_sheets/bottom_sheets.dart';

import 'package:dd/core/util/barrel.dart';
import 'package:dd/features/focus_timer/presentation/focus_timer_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../pages/foucs_timer_pages/focus_timer_page.dart';

class FocusTimerBottomSheet extends BottomSheetModel {
  FocusTimerBottomSheet(
      {super.presentation = const FocusTimerBottomSheetPresentation(),
      super.title = 'Focus for how long ?'});
}

class FocusTimerBottomSheetPresentation extends HookConsumerWidget {
  const FocusTimerBottomSheetPresentation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourController = useTextEditingController();
    final minuteController = useTextEditingController();
    final secondController = useTextEditingController();

    // DateTime? dueDate = DateTime.now();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContainerWithTextField(
            controller: hourController,
            label: 'Hour',
          ),
          const Text(
            ':',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 52),
          ),
          ContainerWithTextField(controller: minuteController, label: 'Minute'),
          const Text(
            ':',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 52),
          ),
          ContainerWithTextField(controller: secondController, label: 'Second')
        ],
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
                onPressed: () {
                  String hourText = hourController.text;
                  String minuteText = minuteController.text;
                  String secondText = secondController.text;

                  hourText.isEmpty ? hourText = '0' : hourText;
                  minuteText.isEmpty ? minuteText = '0' : minuteText;
                  secondText.isEmpty ? secondText = '0' : secondText;

                  final timer =
                      ref.watch(focusTimerControllerProvider.notifier);
                  timer.setTimer(
                      hour: hourText, minute: minuteText, second: secondText);

                  final hour = int.parse(hourText);
                  final minute = int.parse(minuteText);
                  final second = int.parse(secondText);

                  final timerDuration =
                      Duration(hours: hour, minutes: minute, seconds: second);
                  hourController.clear();
                  minuteController.clear();
                  secondController.clear();

                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FocusTimerPage(timerDuration: timerDuration),
                      ));
                },
                child: const Text(
                  'Start Timer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ])
    ]);
  }
}

class ContainerWithTextField extends HookConsumerWidget {
  const ContainerWithTextField(
      {super.key, required this.controller, required this.label});
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 82,
              // height: 78,
              child: TextField(
                controller: controller,
                expands: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                maxLength: 2,
                style: const TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    focusColor: AppColors.purple,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: AppColors.purple),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: '00',
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    counterText: '',
                    contentPadding: const EdgeInsets.all(16),
                    border: InputBorder.none),
                keyboardType: TextInputType.number,
              )),
          const Gap(
            height: 8,
          ),
          Text(label)
        ],
      ),
    );
  }
}
