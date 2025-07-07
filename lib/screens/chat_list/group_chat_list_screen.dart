import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants.dart';

class GroupChatListScreen extends ConsumerStatefulWidget {
  const GroupChatListScreen({super.key});

  @override
  ConsumerState<GroupChatListScreen> createState() => _GroupChatListScreen();
}

class _GroupChatListScreen extends ConsumerState<GroupChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Stack(
                            children: [
                               CircleAvatar(
                                 backgroundColor: Colors.white,
                                 radius: 24,
                                 child: CircleAvatar(
                                  foregroundImage: AssetImage(
                                    "assets/icons/profile_pic.png",
                                  ),
                                  radius: 22,
                                                             ),
                               ),
                              Positioned(
                                left: 15,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                radius: 24,
                                  child: CircleAvatar(
                                    foregroundImage: AssetImage(
                                      "assets/icons/profile_pic.png",
                                    ),
                                    radius: 22,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    foregroundImage: AssetImage(
                                      "assets/icons/profile_pic.png",
                          
                                    ),
                                    radius: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                        Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "David Wayne",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "10:25",
                                    style: TextStyle(
                                      color: Constants.neutral300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Thanks a bunch Have a great day",
                                      style: TextStyle(
                                        color: Constants.neutral300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "5",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
