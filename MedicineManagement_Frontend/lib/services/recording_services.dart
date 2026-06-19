import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class RecordingService {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;

  bool get isRecording => _isRecording;

  Future<void> startRecording() async {
    bool grantedPermission = await requestPermission();
    if (!grantedPermission) {
      throw Exception("Permission denied.");
    }
    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
    _isRecording = true;
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) {
      return null;
    }
    final path = await _recorder.stop();
    _isRecording = false;
    return path;
  }

  Future<bool> requestPermission() async {
    PermissionStatus status = await Permission.microphone.request();

    return status.isGranted;
  }
  
  void dispose(){
    _recorder.dispose();
  }
}
