import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.message), // Smaller icon
            SizedBox(width: 2), // Smaller spacing
            Text(
              "E-Chat", // Smaller text
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 32)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 32)),
        ],
      ),
      body: Column(mainAxisSize: MainAxisSize.max),
      bottomNavigationBar: Card(elevation: 200,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
          ),
          width: double.infinity,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItems(
                  width: width,
                  icon: Icons.chat,
                  color: Colors.transparent,
                  text: "Chat",
                ),
                _navItems(
                  width: width,
                  icon: Icons.chat,
                  color: Colors.transparent,
                  text: "Chat",
                ),
                _navItems(
                  width: width,
                  icon: Icons.chat,
                  color: Colors.transparent,
                  text: "Chat",
                ),
                _navItems(
                  width: width,
                  icon: Icons.chat,
                  color: Colors.blue,
                  text: "Chat",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _navItems({
  required IconData icon,
  required Color color,
  required String text,
  required double width,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    height: 60,
    width: width / 8,
    child: Column(
      children: [
        SizedBox(height: 8),
        Icon(
          icon,
          color: color != Colors.transparent ? Colors.white : Colors.black,
        ),
        SizedBox(height: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color != Colors.transparent ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
