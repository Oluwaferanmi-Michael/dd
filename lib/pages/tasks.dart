import 'package:dd/pages/home/components/components.dart';
import 'package:timelines/timelines.dart';
import '../core/util/barrel.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                  height: 12,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black26,
                  ),
                  child: const Text(
                    'Create To-do',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(
                  height: 24,
                ),
                const TasksDaySelector(),
                const Gap(
                  height: 24,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    // color: Colors.redAccent,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        child: Timeline.tileBuilder(
                            builder: TimelineTileBuilder.fromStyle(
                      contentsBuilder: (content, index) {
                        return Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                                'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata'));
                      },
                      itemCount: 2,
                    ))),
                  ),
                )
              ],
            )));
  }
}
