import 'package:uuid/uuid.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../datasets/datasets.dart';

/// Local data store — all data is persisted in memory.
/// Set `useRealBackend = true` in AppConfig when your Supabase/FastAPI is ready.
class MockDataService {
  static const _uuid = Uuid();

  List<NoteModel> notes = [];
  UserModel? currentUser;
  bool isLoggedIn = false;

  MockDataService() {
    _seedData();
  }

  void _seedData() {
    notes = List.from(Datasets.seedNotes);

    // Pre-fill the test user (not logged in yet — just seed data)
    currentUser = Datasets.testUser;
  }

  void refreshNotes() {}
  void refreshUser() {}

  // --- Auth ---

  /// Attempts login with the seeded test credentials.
  /// Replace this with Supabase Auth when `AppConfig.useSupabaseAuth = true`.
  bool login(String email, String password) {
    if (email == Datasets.testUser.email && password == Datasets.testPassword) {
      isLoggedIn = true;
      currentUser = Datasets.testUser;
      return true;
    }
    return false;
  }

  /// Creates a new local user session.
  void signup(String email, String password, String username) {
    isLoggedIn = true;
    currentUser = UserModel(
      id: _uuid.v4(),
      displayName: username,
      username: '@${username.toLowerCase().replaceAll(' ', '')}',
      email: email,
      bio: 'New to Chitpad!',
    );
  }

  void logout() {
    isLoggedIn = false;
  }

  // --- Notes ---

  List<NoteModel> getAllNotes() => notes.toList();

  NoteModel? getNoteById(String id) {
    try {
      return notes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  NoteModel createNote(NoteModel note) {
    final newNote = NoteModel(
      id: _uuid.v4(),
      title: note.title,
      deltaJson: note.deltaJson,
      tag: note.tag,
      starred: note.starred,
      archived: note.archived,
      pinned: note.pinned,
    );
    notes.insert(0, newNote);
    return newNote;
  }

  NoteModel? updateNote(String id, Map<String, dynamic> updates) {
    final idx = notes.indexWhere((n) => n.id == id);
    if (idx == -1) return null;
    final note = notes[idx];
    if (updates.containsKey('title')) note.title = updates['title'];
    if (updates.containsKey('delta_json')) {
      note.deltaJson = updates['delta_json'];
    }
    if (updates.containsKey('tag')) note.tag = updates['tag'];
    if (updates.containsKey('starred')) note.starred = updates['starred'];
    if (updates.containsKey('archived')) note.archived = updates['archived'];
    if (updates.containsKey('pinned')) note.pinned = updates['pinned'];
    note.updatedAt = DateTime.now();
    notes[idx] = note;
    return note;
  }

  bool deleteNote(String id) {
    final len = notes.length;
    notes.removeWhere((n) => n.id == id);
    return notes.length < len;
  }
}
