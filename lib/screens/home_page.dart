import 'package:flutter/material.dart';
import 'package:talk_with_gpt/colors.dart';
import 'package:talk_with_gpt/widgets/chat_bubble.dart';
import 'package:talk_with_gpt/widgets/feature_box.dart';
import 'package:talk_with_gpt/widgets/virtual_assistant_picture.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.mic),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MAB"),
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          const VirtualAssistantPicture(),
          const ChatBubble(),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Here are a few features",
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontFamily: "Cera Pro",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ///features list
          Column(
            children: const [
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: "ChatGPT",
                descriptionText:
                    "A smarter way to stay organized and informed with ChatGPT",
              ),
              FeatureBox(
                color: Pallete.secondSuggestionBoxColor,
                headerText: "Dall-E",
                descriptionText:
                    "Get inspired ans stay creative with your assistant powered by Dall-E",
              ),
              FeatureBox(
                color: Pallete.thirdSuggestionBoxColor,
                headerText: "Smart Voice Assistant",
                descriptionText:
                    "Get the best of both worlds and voice assistant powered by Dall-E and ChatGPT",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
