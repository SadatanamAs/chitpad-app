import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note_model.dart';
import '../providers/mock_data_service.dart';
import '../../app/providers/app_providers.dart';

class NotesRepository {
  final Ref ref;
  NotesRepository(this.ref);

  MockDataService get _mock => ref.read(mockDataServiceProvider);

  List<NoteModel> getAllNotes() => _mock.getAllNotes();

  NoteModel? getNoteById(String id) => _mock.getNoteById(id);

  NoteModel createNote(NoteModel note) => _mock.createNote(note);

  NoteModel? updateNote(String id, Map<String, dynamic> updates) =>
      _mock.updateNote(id, updates);

  bool deleteNote(String id) => _mock.deleteNote(id);

  List<NoteModel> getActiveNotes() =>
      getAllNotes().where((n) => !n.archived).toList();

  List<NoteModel> getArchivedNotes() =>
      getAllNotes().where((n) => n.archived).toList();

  List<NoteModel> getStarredNotes() =>
      getActiveNotes().where((n) => n.starred).toList();

  List<NoteModel> getNotesByTag(String tag) =>
      getActiveNotes().where((n) => n.tag == tag).toList();

  List<NoteModel> searchNotes(String query) {
    final q = query.toLowerCase();
    return getActiveNotes()
        .where(
          (n) =>
              n.title.toLowerCase().contains(q) ||
              n.plainText.toLowerCase().contains(q),
        )
        .toList();
  }
}
