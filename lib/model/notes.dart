import 'dart:convert';

class Notes {
  final String notesClass;
  final String subject;
  final String chapter;
  final String lecture;
  Notes({
    required this.notesClass,
    required this.subject,
    required this.chapter,
    required this.lecture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notesClass': notesClass,
      'subject': subject,
      'chapter': chapter,
      'lecture': lecture,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      notesClass: map['notesClass'] as String,
      subject: map['subject'] as String,
      chapter: map['chapter'] as String,
      lecture: map['lecture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source) as Map<String, dynamic>);
}
