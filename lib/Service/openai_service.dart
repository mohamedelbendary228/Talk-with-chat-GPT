import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:talk_with_gpt/utils/dio_client.dart';
import 'package:dio/dio.dart';

class OpenAIService {
  final DioClient _dioClient = DioClient.instance;

  final List<Map<String, String>> messages = [];

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
        String content = response.data["choices"][0]["message"]["content"];
        content = content.trim();

        switch (content) {
          case "Yes":
          case "yes":
          case "Yes.":
          case "yes.":
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPT(prompt);
            return res;
        }
      }

      return "An internal error occurred";
    } on DioError catch (e) {
      return e.toString();
    }
  }

  //generate a text
  Future<String> chatGPTAPT(String prompt) async {
    //Store whatever the user says to got the messages history
    messages.add(
      {
        "role": "user",
        "content": prompt,
      },
    );

    FormData formData = FormData.fromMap(
      {
        "model": "gpt-3.5-turbo",
        "messages": messages,
      },
    );

    try {
      final Response response = await _dioClient
          .post("https://api.openai.com/v1/chat/completions", data: formData);

      if (response.statusCode == 200) {
        String content = response.data["choices"][0]["message"]["content"];
        content = content.trim();

        //Store whatever the assistant says to got the messages history
        messages.add(
          {
            "role": "assistant",
            "content": content,
          },
        );

        return content;
      }
      return "An internal error occurred";
    } on DioError catch (e) {
      return e.toString();
    }
  }

  //generate an image
  Future<String> dallEAPI(String prompt) async {
    return "dallEAPI";
  }
}
