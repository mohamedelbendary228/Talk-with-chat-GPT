import 'package:flutter/material.dart';
import 'package:talk_with_gpt/colors.dart';

class VirtualAssistantPicture extends StatelessWidget {
  const VirtualAssistantPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(top: 4.0),
            decoration: const BoxDecoration(
              color: Pallete.assistantCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Container(
            height: 123,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/virtualAssistant.png",
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
