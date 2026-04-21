import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../data/models/note_model.dart';
import '../../data/providers/mock_data_service.dart';
import '../../data/repositories/notes_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/providers/app_providers.dart';

class NoteEditorController extends ChangeNotifier {
  final Ref ref;
  final String? noteId;

  NotesRepository get _notesRepo => ref.read(notesRepositoryProvider);
  MockDataService get _mock => ref.read(mockDataServiceProvider);

  late QuillController quillController;
  late TextEditingController titleController;
  late FocusNode editorFocusNode;
  late ScrollController editorScrollController;

  String title = '';
  String selectedTag = '';
  int wordCount = 0;
  bool isNewNote = true;

  // Deferred-notification dirty flags — prevent setState during build phase
  bool _titleDirty = false;
  bool _wordCountDirty = false;

  NoteEditorController(this.ref, this.noteId) {
    _init();
  }

  void _init() {
    editorFocusNode = FocusNode();
    editorScrollController = ScrollController();
    titleController = TextEditingController();

    // Defer notifyListeners so it fires after the current frame — never during build
    titleController.addListener(() {
      title = titleController.text;
      if (!_titleDirty) {
        _titleDirty = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _titleDirty = false;
          notifyListeners();
        });
      }
    });

    if (noteId != null) {
      isNewNote = false;
      final note = _notesRepo.getNoteById(noteId!);
      if (note != null) {
        title = note.title;
        titleController.text = note.title;
        selectedTag = note.tag;
        try {
          final doc = Document.fromJson(note.deltaJson);
          quillController = QuillController(
            document: doc,
            selection: const TextSelection.collapsed(offset: 0),
          );
        } catch (_) {
          quillController = QuillController.basic();
        }
      } else {
        quillController = QuillController.basic();
      }
    } else {
      isNewNote = true;
      quillController = QuillController.basic();
    }

    // Quill document changes — deferred word count update
    quillController.document.changes.listen((_) {
      if (!_wordCountDirty) {
        _wordCountDirty = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _wordCountDirty = false;
          _updateWordCount();
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateWordCount();
    });
  }

  void _updateWordCount() {
    final text = quillController.document.toPlainText().trim();
    wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    notifyListeners();
  }

  void setTag(String tag) {
    selectedTag = tag;
    notifyListeners();
  }

  void save() {
    final deltaJson = quillController.document.toDelta().toJson();
    final noteTitle = title.trim().isEmpty ? 'Untitled' : title.trim();

    if (isNewNote) {
      _notesRepo.createNote(
        NoteModel(
          id: '',
          title: noteTitle,
          deltaJson: deltaJson,
          tag: selectedTag,
        ),
      );
    } else {
      _notesRepo.updateNote(noteId!, {
        'title': noteTitle,
        'delta_json': deltaJson,
        'tag': selectedTag,
      });
    }
    _mock.refreshNotes();
    ref.read(homeProvider.notifier).notifyListeners();

    Get.snackbar(
      'Saved',
      '',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
    );
    Get.offAllNamed(AppRoutes.home);
  }

  void autoSaveThenGoBack() {
    final deltaJson = quillController.document.toDelta().toJson();
    final noteTitle = title.trim().isEmpty ? 'Untitled' : title.trim();

    if (isNewNote) {
      _notesRepo.createNote(
        NoteModel(
          id: '',
          title: noteTitle,
          deltaJson: deltaJson,
          tag: selectedTag,
        ),
      );
    } else {
      _notesRepo.updateNote(noteId!, {
        'title': noteTitle,
        'delta_json': deltaJson,
        'tag': selectedTag,
      });
    }
    _mock.refreshNotes();
    ref.read(homeProvider.notifier).notifyListeners();
    Get.back();
  }

  void toggleStar() {
    if (noteId == null) return;
    final note = _notesRepo.getNoteById(noteId!);
    if (note != null) {
      _notesRepo.updateNote(noteId!, {'starred': !note.starred});
      _mock.refreshNotes();
      notifyListeners();
      Get.snackbar(
        note.starred ? 'Removed from starred' : 'Added to starred',
        '',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
      );
    }
  }

  bool get isStarred {
    if (noteId == null) return false;
    final note = _notesRepo.getNoteById(noteId!);
    return note?.starred ?? false;
  }

  @override
  void dispose() {
    titleController.dispose();
    editorFocusNode.dispose();
    editorScrollController.dispose();
    quillController.dispose();
    super.dispose();
  }
}
