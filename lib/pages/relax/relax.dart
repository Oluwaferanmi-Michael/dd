import 'package:dd/config/presentation/strings.dart';

import '../../core/util/barrel.dart';

class RelaxPage extends ConsumerWidget {
  const RelaxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text(
          Strings.relaxPageIntro,
          style: TextStyle(fontSize: 20),
        ),
        const Gap(
          height: 24,
        ),
        Flexible(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Gap(
              height: 12,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('data'), Text('data')],
                    ),
                  ));
            },
          ),
        )
      ]),
    ));
  }
}
