import 'package:flutter_quill/flutter_quill.dart';

class NoteModel {
  final String id;
  String title;
  List<dynamic> deltaJson; // Quill Delta JSON
  String tag; // 'Work', 'Personal', 'Ideas', ''
  bool starred;
  bool archived;
  bool pinned;
  DateTime createdAt;
  DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    List<dynamic>? deltaJson,
    this.tag = '',
    this.starred = false,
    this.archived = false,
    this.pinned = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : deltaJson =
           deltaJson ??
           [
             {'insert': '\n'},
           ],
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  String get plainText {
    try {
      final doc = Document.fromJson(deltaJson);
      return doc.toPlainText().trim();
    } catch (_) {
      return '';
    }
  }

  String get preview {
    final text = plainText;
    if (text.length > 120) return '${text.substring(0, 120)}…';
    return text;
  }

  int get wordCount {
    final text = plainText;
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  String get dateLabel {
    final now = DateTime.now();
    final diff = now.difference(updatedAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24 && updatedAt.day == now.day) {
      return 'Today, ${_formatTime(updatedAt)}';
    }
    if (diff.inHours < 48) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${_months[updatedAt.month - 1]} ${updatedAt.day}';
  }

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _formatTime(DateTime dt) {
    final h = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'delta_json': deltaJson,
    'tag': tag,
    'starred': starred,
    'archived': archived,
    'pinned': pinned,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    deltaJson:
        json['delta_json'] ??
        [
          {'insert': '\n'},
        ],
    tag: json['tag'] ?? '',
    starred: json['starred'] ?? false,
    archived: json['archived'] ?? false,
    pinned: json['pinned'] ?? false,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : DateTime.now(),
  );

  NoteModel copyWith({
    String? title,
    List<dynamic>? deltaJson,
    String? tag,
    bool? starred,
    bool? archived,
    bool? pinned,
  }) => NoteModel(
    id: id,
    title: title ?? this.title,
    deltaJson: deltaJson ?? this.deltaJson,
    tag: tag ?? this.tag,
    starred: starred ?? this.starred,
    archived: archived ?? this.archived,
    pinned: pinned ?? this.pinned,
    createdAt: createdAt,
    updatedAt: DateTime.now(),
  );
}
