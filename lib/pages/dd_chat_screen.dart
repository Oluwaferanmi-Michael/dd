import 'package:dd/config/theme/app_colors.dart';
import 'package:dd/config/widgets/gap.dart';
import 'package:dd/core/util/ext.dart';
import 'package:dd/features/chat_with_dd/domain/entities/chat_entity.dart';
import 'package:dd/features/chat_with_dd/presentation/chat_controller.dart';
import 'package:dd/core/resources/constants/strings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../config/theme/insets.dart';

class ChatWithDDScreen extends HookConsumerWidget {
  const ChatWithDDScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final chat = ref.watch(chatControllerProvider);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: () => Navigator.pop(context, true)),
          title: const Text('Chat with DD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: chat.when(
                        data: (value) => Align(
                              alignment: Alignment.topCenter,
                              child: ListView.separated(
                                  separatorBuilder: (_, index) => const Gap(
                                        height: 12,
                                      ),
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    return ChatList(
                                      chat:
                                          value.elementAt(index).message.trim(),
                                      from: value.elementAt(index).from,
                                    );
                                  }),
                            ),
                        error: (e, s) => const FlutterLogo(),
                        loading: () =>
                            const Center(child: LinearProgressIndicator()))),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(Insets.twelve),
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.lightGrey,
                          ),
                          padding: const EdgeInsets.all(Insets.twelve),
                          child: TextField(
                            controller: textController,
                            maxLines: null,
                            minLines: null,
                            decoration: const InputDecoration(
                                hintText: Strings.textFieldHint,
                                hintStyle:
                                    TextStyle(fontStyle: FontStyle.italic),
                                border: InputBorder.none,
                                isCollapsed: true),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                          onPressed: () async {
                            await ref
                                .read(chatControllerProvider.notifier)
                                .chat(message: textController.text);
                            textController.clear();
                            scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          icon: const Icon(Icons.send_outlined))
                    ],
                  ),
                )
              ]),
        ));
  }
}

class ChatList extends HookConsumerWidget {
  final String from;
  final String chat;
  const ChatList({super.key, required this.from, required this.chat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: from == MessageFrom.ai.string()
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * .8,
          ),
          padding: const EdgeInsets.all(Insets.twelve),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: from == MessageFrom.ai.string()
                ? AppColors.lightGrey
                : AppColors.seed,
          ),
          child: from == MessageFrom.ai.string()
              ? MarkdownBody(
                  data: chat,
                  selectable: true,
                  
                )
              : Text(chat),
        ),
      ],
    );
  }
}
