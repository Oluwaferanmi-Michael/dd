import 'package:dd/core/env/env.dart';
import 'package:dd/core/util/typedefs.dart';
// import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../core/resources/constants/ai_constants.dart';

class GeminiSource {
  const GeminiSource();

  Future<String?> chatModel(
      {required String userText, required List<Content> history}) async {
    var apiKey = ApiEnv.gemKey;

    final safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
    ];
    var model = GenerativeModel(
        systemInstruction: Content.system(AiConstants.systemInstructions),
        model: AiConstants.gemFlashModel,
        apiKey: apiKey,
        safetySettings: safetySettings);

    final content = Content.text(userText);

    final chat =
        model.startChat(history: history, generationConfig: GenerationConfig());

    final response = await chat.sendMessage(content);
    // generateContent(content);
    return response.text;
  }

  Future<void> createSteps({required Task task}) async {
    final apiKey = ApiEnv.gemKey;

    var stepsModel = GenerativeModel(
        apiKey: apiKey,
        model: AiConstants.gemFlashModel,
        systemInstruction:
            Content.system(AiConstants.stepGenerationInstructions));

    final prompt = [Content.text(task)];

    final step = await stepsModel.generateContent(prompt);

    return;
  }

  Future<String?> createTip({required Note note}) async {
    final apiKey = ApiEnv.gemKey;

    var noteModel = GenerativeModel(
        apiKey: apiKey,
        model: AiConstants.gemFlashModel,
        systemInstruction:
            Content.system(AiConstants.noteThoughtsInstructions));

    final prompt = [Content.text(note)];

    final thoughts = await noteModel.generateContent(prompt);

    return thoughts.text;
  }
}
