import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:talk_with_gpt/utils/dio_client.dart';
import 'package:dio/dio.dart';

class OpenAIService {
  final DioClient _dioClient = DioClient.instance;

  //This Function tell us if the user want to generate an Art (image) or not
  Future<String> isArtPromptAPI(String prompt) async {
    FormData formData = FormData.fromMap({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content":
              "Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no."
        }
      ],
    });

    try {
      final Response response = await _dioClient
          .post("https://api.openai.com/v1/chat/completions", data: formData);

      if (response.statusCode == 200) {
        print("yaaaaay");
      }
      return "AIIIIIIIII";
    } on DioError catch (e) {
      debugPrint("e.message ${e.message}");
      debugPrint("e.response ${e.response}");
      return e.toString();
    }
  }

  //generate a text
  Future<String> chatGPTAPT(String prompt) async {
    return 'chatGPTAPT';
  }

  //generate an image
  Future<String> dallEAPI(String prompt) async {
    return "dallEAPI";
  }
}
