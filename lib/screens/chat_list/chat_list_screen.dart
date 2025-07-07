import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> with TickerProviderStateMixin {
  late List<AnimationController> _scaleControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<AnimationController> _pulseControllers;
  late List<Animation<double>> _pulseAnimations;

  @override
  void initState() {
    super.initState();
    // Controllers for avatar scale animation
    _scaleControllers = List.generate(20, (index) => AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    ));
    _scaleAnimations = _scaleControllers.map((controller) => Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut))).toList();

    // Controllers for badge pulse animation
    _pulseControllers = List.generate(20, (index) => AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    ));
    _pulseAnimations = _pulseControllers.map((controller) => Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut))).toList();

    // Start avatar scale animations with stagger
    for (int i = 0; i < _scaleControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) _scaleControllers[i].forward();
      });
    }

    // Start badge pulse animations (repeating)
    for (var controller in _pulseControllers) {
      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    // Dispose avatar scale controllers
    for (var controller in _scaleControllers) {
      controller.dispose();
    }
    // Dispose badge pulse controllers
    for (var controller in _pulseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimations[index],
                          child: const CircleAvatar(
                            foregroundImage: AssetImage("assets/icons/profile_pic.png"),
                            radius: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "David Wayne",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "10:25",
                                    style: TextStyle(color: Constants.neutral300),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Thanks a bunch Have a great day",
                                      style: TextStyle(color: Constants.neutral300),
                                    ),
                                  ),
                                  ScaleTransition(
                                    scale: _pulseAnimations[index],
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Text("5", style: TextStyle(color: Colors.white)),
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