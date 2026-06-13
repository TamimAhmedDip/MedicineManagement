class Recording {
  final String id;
  final String transcription;
  final String aiSummary;
  final DateTime date;
  final String filePath;

  Recording({
    required this.id,
    required this.transcription,
    required this.aiSummary,
    required this.date,
    required this.filePath,
  });

  factory Recording.fromMap(Map<String, dynamic> map) {
    return Recording(
      id: map['id'],
      transcription: map['transcription'],
      aiSummary: map['aiSummary'],
      date: DateTime.parse(map['date']),
      filePath: map['filePath'],
    );
  }

  Map<String, dynamic> toMap(Recording recording) {
    return {
      'id': id,
      'transcription': transcription,
      'aiSummary': aiSummary,
      'date': date.toIso8601String(),
      'filePath': filePath,
    };
  }
} 