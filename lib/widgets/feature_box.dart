import 'package:flutter/material.dart';
import 'package:talk_with_gpt/utils/colors.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;

  const FeatureBox({Key? key, required this.color, required this.headerText, required this.descriptionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0).copyWith(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerText,
              style: const TextStyle(
                fontFamily: "Cera Pro",
                color: Pallete.mainFontColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),

            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                descriptionText,
                style: const TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.blackColor,
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
