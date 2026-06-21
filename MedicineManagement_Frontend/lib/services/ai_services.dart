import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meds_manager/config/api_keys.dart';

class AiServices {
  Future<String?> transcribeAudio(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final base64Audio = base64Encode(bytes);

    final requestBody = {
      'config': {
        'languageCode': 'bn-BD',
        'model': 'latest_long',
        'encoding': 'LINEAR16',
        'sampleRateHertz': 16000,
      },
      'audio': {'content': base64Audio},
    };
    apiKeys keys = apiKeys();
    String cloudKey = keys.googleCloudKey;
    final response = await http.post(
      Uri.parse(
        'https://speech.googleapis.com/v1/speech:recognize?key=${cloudKey}',
      ),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final data = jsonDecode(response.body);
    return data['results'][0]['alternatives'][0]['transcript'];
  }
}
