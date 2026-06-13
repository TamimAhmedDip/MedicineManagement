import 'package:flutter/material.dart';

enum RecordingState { idle, recording, processing, success, error }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecordingState _currentState = RecordingState.idle;
  Widget _buildMicButton() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _currentState == RecordingState.recording ? 120 : 80,
      height: _currentState == RecordingState.recording ? 120 : 80,
      decoration: BoxDecoration(
        color: _currentState == RecordingState.recording
            ? Colors.red
            : Colors.blue,
        shape: BoxShape.circle
      ),
      child: Icon(Icons.mic),
    );
  }

  Widget _buildBody(RecordingState currentState) {
    switch (currentState) {
      case RecordingState.idle:
        return Column(
          children: [
            Text('Idle'),
            _buildMicButton(),
          ],
        );
      case RecordingState.recording:
        return Column(
          children: [
            Text('Recording'),
            _buildMicButton(),
          ],
        );
      case RecordingState.processing:
        return Column(
          children: [Text('Processing'), Icon(Icons.hourglass_bottom)],
        );
      case RecordingState.success:
        return Column(children: [Text('Success'), Icon(Icons.check_circle)]);
      case RecordingState.error:
        return Column(children: [Text('Error'), Icon(Icons.error)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBody(_currentState),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('See other states!'),
              onPressed: () {
                setState(() {
                  int currentIndex = _currentState.index;
                  int nextIndex =
                      (currentIndex + 1) % RecordingState.values.length;
                  _currentState = RecordingState.values[nextIndex];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
