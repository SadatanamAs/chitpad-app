import 'package:uuid/uuid.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';

/// Static seed data — replace with your real Supabase data when backend is ready.
/// User credentials: sadik917@gmail.com / sadik917
/// You can edit or delete all of this freely.
class Datasets {
  static const _uuid = Uuid();

  static final testUser = UserModel(
    id: _uuid.v4(),
    displayName: 'Sadik',
    username: '@sadik917',
    email: 'sadik917@gmail.com',
    bio: 'Building ideas, one note at a time.',
  );

  static final testPassword = 'sadik917';

  static final List<NoteModel> seedNotes = [
    NoteModel(
      id: _uuid.v4(),
      title: 'Welcome to Chitpad',
      deltaJson: [
        {'insert': 'This is your first note! 🎉'},
        {'insert': '\n'},
        {'insert': '\n'},
        {'insert': 'Tap the + button to create a new note.'},
        {'insert': '\n'},
        {'insert': 'Star notes to save your favourites.'},
        {'insert': '\n'},
        {'insert': 'Tag notes as Work, Personal, or Ideas to stay organized.'},
        {'insert': '\n'},
      ],
      tag: 'Personal',
      starred: true,
      pinned: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    NoteModel(
      id: _uuid.v4(),
      title: 'Project roadmap — Q2',
      deltaJson: [
        {'insert': 'Launch v2.0 by end of Q2'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Migrate to Supabase auth (GoTrue)'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Add real-time collaboration'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'iOS and Android builds'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': '\n'},
        {'insert': 'Revenue target: \$12k MRR'},
      ],
      tag: 'Work',
      starred: true,
      pinned: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    NoteModel(
      id: _uuid.v4(),
      title: 'App ideas',
      deltaJson: [
        {'insert': 'Habit tracker with streaks and social feed'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Recipe vault with ingredient scaling'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Local-first to-do list with offline sync'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Mood journal with weekly analytics'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
      ],
      tag: 'Ideas',
      starred: false,
      pinned: false,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    NoteModel(
      id: _uuid.v4(),
      title: 'Reading list 2026',
      deltaJson: [
        {'insert': 'Atomic Habits — James Clear'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'The Design of Everyday Things — Don Norman'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'A Philosophy of Software Design — John Ousterhout'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Staff Engineer — Will Larson'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
      ],
      tag: 'Personal',
      starred: false,
      pinned: false,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    NoteModel(
      id: _uuid.v4(),
      title: 'Grocery run',
      deltaJson: [
        {'insert': 'Eggs'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Sourdough bread'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Olive oil'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Parmesan'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Fresh basil'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
        {'insert': 'Cherry tomatoes'},
        {
          'insert': '\n',
          'attributes': {'list': 'bullet'},
        },
      ],
      tag: 'Personal',
      starred: false,
      archived: true,
      pinned: false,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];
}
