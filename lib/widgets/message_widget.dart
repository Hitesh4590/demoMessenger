import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget{
  final String text;
  final bool isSent;

  const MessageWidget({
    required this.text,
    required this.isSent,
});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxBubbleWidth = screenWidth * 0.75; // 75% of screen width

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        constraints: BoxConstraints(
          maxWidth: maxBubbleWidth
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSent ? Color(0xFF1565C0) : Colors.white,
          borderRadius: isSent ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0), topLeft: Radius.circular(10), topRight: Radius.circular(10)) : BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, color: isSent ? Colors.white : Colors.black),),
      ),
    );
  }

}