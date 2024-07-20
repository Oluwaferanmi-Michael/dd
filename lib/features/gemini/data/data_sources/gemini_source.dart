
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../core/resources/constants/ai_constants.dart';

class GeminiSource {
  const GeminiSource();


  Future<String?> chatModel({
    required String userText,
    required List<Content> history 
  }) async {
    var apiKey = '';

    final safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
    ];
    var model = GenerativeModel(
      systemInstruction: Content.system(AiConstants.systemInstructions),
      model: AiConstants.gemFlashModel, apiKey: apiKey,
      safetySettings: safetySettings
      );

    final content = Content.text(userText);

    final chat = model.startChat(
      history: history,
      generationConfig: GenerationConfig()
    );

    final response = await chat.sendMessage(content);
    // generateContent(content);
    return response.text;
    }
}