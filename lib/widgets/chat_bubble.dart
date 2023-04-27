import 'package:flutter/material.dart';
import 'package:talk_with_gpt/colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key}) : super(key: key);

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
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Good Morning, What task can I do for you?",
          style: TextStyle(
              color: Pallete.mainFontColor,
              fontSize: 25,
              fontFamily: "Cera Pro"),
        ),
      ),
    );
  }
}
