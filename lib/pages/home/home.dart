import 'package:dd/core/util/barrel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          // height: MediaQuery.sizeOf(context).height,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(children: [
            Section1(),
            Gap(
              height: 12,
            ),
            Section2(),
            Gap(
              height: 12,
            ),
            Section3()
          ]),
        ),
      ),
    ));
  }
}
