import 'package:flutter/material.dart';
import 'package:talk_with_gpt/utils/colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final double fontSize;
  const ChatBubble({Key? key, required this.text, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      margin:
      const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.borderColor),
        borderRadius:
        BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
              color: Pallete.mainFontColor,
              fontSize: fontSize,
              fontFamily: "Cera Pro"),
        ),
      ),
    );
  }
}
