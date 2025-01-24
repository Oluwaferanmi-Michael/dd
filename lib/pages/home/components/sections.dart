import 'package:dd/config/theme/insets.dart';
import 'package:dd/config/widgets/animations/dd_idle_animation.dart';
import 'package:dd/core/util/barrel.dart';

import '../../dd_chat_screen.dart';
import 'components.dart';

class Section1 extends ConsumerWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height / 3) - 20,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChatWithDDScreen())),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(16)),
                        child: const DdIdleAnimationWidget()),
                  ),
                  const Gap(
                    height: 12,
                  ),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: Insets.twelve),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Chat with DD',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
          ),
          const Gap(
            width: 12,
          ),
          const Expanded(
            child: NotesSummary(),
          )
        ],
      ),
    );
  }
}

class Section2 extends ConsumerWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // color: Colors.purple[300],
      height: (MediaQuery.sizeOf(context).height / 3) - 20,
      child: const Column(
        children: [
          Expanded(child: TipComponent()),
          Gap(height: 12),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  StreakComponent(),
                  Gap(
                    width: 12,
                  ),
                  Expanded(child: SelectedTaskSummary())
                ],
              ))
        ],
      ),
    );
  }
}

class Section3 extends ConsumerWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height / 3) - 100,
      // color: Colors.green,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const Expanded(
                child: FocusTimerComponent(),
              ),
              // const Gap(height: 12),
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.black26,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     alignment: Alignment.center,
              //     child: const Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             'Instant Meditation',
              //             style: TextStyle(fontSize: 16),
              //           ),
              //           Icon(Icons.all_inclusive_outlined)
              //         ]),
              //   ),
              // )
            ],
          ),
        ),
        const Gap(width: 12),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: const UserPointsView(),
          ),
        )
      ]),
    );
  }
}
