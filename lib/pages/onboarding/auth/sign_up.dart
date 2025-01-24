import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/resources/constants/image_constants.dart';

import '../../../features/auth/presentation/controllers/authentication_controller.dart';

class SignUpScreen extends HookConsumerWidget{
const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final emailController = useTextEditingController();
    // final userNameController = useTextEditingController();

    // ref.watch();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topRight,
                          children: [
                            
                          const  CircleAvatar(
                          radius: 48,
                          foregroundImage: AssetImage(ImageConstants.ddProfile),),             
                          Positioned(
                            top: 8,
                            right: -30,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(500),
                                                    ),
                                child: const Text('hey there !'),
                              ),
                          ),
                          ],
                        )),
                        

                        const SizedBox(
                        height: 24,
                      ), 
                      
                      const Text('sign in'),

                      const SizedBox(
                        height: 24,
                      ), 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: TextButton(onPressed: () async {
                          await ref.read(authServiceProvider.notifier).signInWithGoogle();
                        }, child: const Text('sign in with google')),
                      ),
                      // const Divider(),
                    
                    ]
                  )
                )
                
              ],
            ),
          ),
        )
      )
    );
  }
}