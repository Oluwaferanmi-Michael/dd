import 'package:dd/core/util/logger.dart';
import 'package:dd/features/auth/presentation/controllers/authentication_controller.dart';
import 'package:dd/features/gemini/presentation/controllers/gemini_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';


import '../features/gemini/presentation/controllers/providers/gemini_chat_provider.dart';

class ChatWithDDScreen extends HookConsumerWidget {
  const ChatWithDDScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text('Talk with DD',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            actions: [
              TextButton(
                onPressed: ref.read(authServiceProvider.notifier).logOut,
                child: const Text('log out'),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(child: ChatList()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: textController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(geminiControllerProvider.notifier)
                              .getGeminiResponse(prompt: textController.text);
                          textController.clear();
                        },
                        icon: const Icon(Icons.send_rounded))
                  ],
                )
              ]),
        ));
  }
}

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chat = ref.watch(geminiControllerProvider);
    final chatListProvider = ref.watch(geminiChatProvider);

    // chat.log('ui ');
    chatListProvider.log('chat list provider');

    return chat.when(
        data: (value) => ListView.builder(
            reverse: false,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            itemCount: value.length,
            itemBuilder: (context, index) {
              // final chats = data[index];
              return Container(
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(value.elementAt(index).message));
            }),
        error: (e, s) => const FlutterLogo(),
        loading: () => const CircularProgressIndicator.adaptive());
  }
}
