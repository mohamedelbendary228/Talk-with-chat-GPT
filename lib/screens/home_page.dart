import 'package:flutter/material.dart';
import 'package:talk_with_gpt/Service/openai_service.dart';
import 'package:talk_with_gpt/utils/colors.dart';
import 'package:talk_with_gpt/widgets/chat_bubble.dart';
import 'package:talk_with_gpt/widgets/feature_box.dart';
import 'package:talk_with_gpt/widgets/virtual_assistant_picture.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final OpenAIService openAIService = OpenAIService();
  String lastWords = "";
  String? generatedContent;
  String? generatedImageUrl;

  //used in slideIn Animation
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
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

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  void onTapRecordButton() async {
    if (await speechToText.hasPermission && speechToText.isNotListening) {
      debugPrint("startListening()");
      await startListening();
    } else if (speechToText.isListening) {
      final speech = await openAIService.isArtPromptAPI(lastWords);
      if (speech.contains("https")) {
        generatedImageUrl = speech;
        generatedContent = null;
        setState(() {});
      } else {
        generatedImageUrl = null;
        generatedContent = speech;
        setState(() {});
        await systemSpeak(speech);
      }
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
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BounceInDown(child: const Text("MAB")),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(child: const VirtualAssistantPicture()),
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: ChatBubble(
                  text: generatedContent ??
                      "Good Morning, What task can I do for you?",
                  fontSize: generatedContent == null ? 25 : 18,
                ),
              ),
            ),

            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!)),
              ),
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: const Padding(
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
              ),
            ),

            ///features list
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: const FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headerText: "ChatGPT",
                      descriptionText:
                          "A smarter way to stay organized and informed with ChatGPT",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay),
                    child: const FeatureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      headerText: "Dall-E",
                      descriptionText:
                          "Get inspired ans stay creative with your assistant powered by Dall-E",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FeatureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      headerText: "Smart Voice Assistant",
                      descriptionText:
                          "Get the best of both worlds and voice assistant powered by Dall-E and ChatGPT",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          onPressed: onTapRecordButton,
          backgroundColor: Pallete.firstSuggestionBoxColor,
          child: speechToText.isNotListening
              ? const Icon(Icons.mic)
              : const Icon(Icons.stop),
        ),
      ),
    );
  }
}
