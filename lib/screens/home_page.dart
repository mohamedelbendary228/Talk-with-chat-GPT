import 'package:flutter/material.dart';
import 'package:talk_with_gpt/Service/openai_service.dart';
import 'package:talk_with_gpt/utils/colors.dart';
import 'package:talk_with_gpt/widgets/chat_bubble.dart';
import 'package:talk_with_gpt/widgets/feature_box.dart';
import 'package:talk_with_gpt/widgets/virtual_assistant_picture.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  String lastWords = "";
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    var locales = await speechToText.locales();
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    debugPrint("lastWords $lastWords");
  }

  void onTapRecordButton() async {
    if (await speechToText.hasPermission && speechToText.isNotListening) {
      debugPrint("startListening()");
      await startListening();
    } else if (speechToText.isListening) {
      final speech = await openAIService.isArtPromptAPI(lastWords);
      debugPrint("Speech: $speech");
      debugPrint("stopListening()");
      await stopListening();
    } else {
      initSpeechToText();
    }
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MAB"),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 70),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapRecordButton,
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: speechToText.isNotListening
            ? const Icon(Icons.mic)
            : const Icon(Icons.stop),
      ),
    );
  }
}
