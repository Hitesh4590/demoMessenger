import 'package:demo_messenger/screens/chat/chat_screen.dart';
import 'package:demo_messenger/screens/chat_list/chat_list_screen.dart';
import 'package:demo_messenger/screens/chat_list/group_chat_list_screen.dart';
import 'package:demo_messenger/screens/profile/profile_screen.dart';
import 'package:demo_messenger/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Widget> _screens = [
    ChatListScreen(),
    GroupChatListScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/Logo.svg"),
            const SizedBox(width: 2),
            const Text(
              "E-Chat",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 32),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 32),
            color: Colors.white,
          ),
        ],
      ),
      body: _screens[selectedIndex],
      bottomNavigationBar: Card(
        elevation: 200,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
          ),
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItems(
                  width: width,
                  icon: "assets/icons/chat_logo.svg",
                  text: "Chat",
                  index: 0,
                  ref: ref,
                ),
                _navItems(
                  width: width,
                  icon: "assets/icons/group_logo.svg",
                  text: "Group",
                  index: 1,
                  ref: ref,
                ),
                _navItems(
                  width: width,
                  icon: "assets/icons/profile_logo.svg",
                  text: "Profile",
                  index: 2,
                  ref: ref,
                ),
                _navItems(
                  width: width,
                  icon: "assets/icons/hamburger_logo.svg",
                  text: "More",
                  index: 3,
                  ref: ref,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItems({
    required String icon,
    required String text,
    required double width,
    required int index,
    required WidgetRef ref,
  }) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        ref.read(selectedNavIndexProvider.notifier).state = index;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 70,
        width: 76,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: SvgPicture.asset(
                icon,

                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
