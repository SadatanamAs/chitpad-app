import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/note_model.dart';
import '../../data/providers/mock_data_service.dart';
import '../../data/repositories/notes_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/providers/app_providers.dart';
import '../../app/theme/app_colors.dart';

class HomeController extends ChangeNotifier {
  final Ref ref;
  final _picker = ImagePicker();

  HomeController(this.ref);

  String? selectedImagePath;

  NotesRepository get _notesRepo => ref.read(notesRepositoryProvider);
  MockDataService get _mock => ref.read(mockDataServiceProvider);

  int currentTab = 0; // 0=notes, 1=archive, 2=profile
  String currentFilter = 'All';
  String searchQuery = '';
  String archiveSearchQuery = '';

  List<NoteModel> get activeNotes {
    var list = _notesRepo.getActiveNotes();

    // Apply filter
    switch (currentFilter) {
      case 'Starred':
        list = list.where((n) => n.starred).toList();
        break;
      case 'Work':
        list = list.where((n) => n.tag == 'Work').toList();
        break;
      case 'Personal':
        list = list.where((n) => n.tag == 'Personal').toList();
        break;
      case 'Ideas':
        list = list.where((n) => n.tag == 'Ideas').toList();
        break;
    }

    // Apply search
    final q = searchQuery.toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where(
            (n) =>
                n.title.toLowerCase().contains(q) ||
                n.plainText.toLowerCase().contains(q),
          )
          .toList();
    }

    // Sort: pinned first
    list.sort((a, b) => (b.pinned ? 1 : 0) - (a.pinned ? 1 : 0));
    return list;
  }

  List<NoteModel> get archivedNotes {
    var list = _notesRepo.getArchivedNotes();
    final q = archiveSearchQuery.toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where(
            (n) =>
                n.title.toLowerCase().contains(q) ||
                n.plainText.toLowerCase().contains(q),
          )
          .toList();
    }
    return list;
  }

  int get totalActiveNotes => _notesRepo.getActiveNotes().length;
  int get totalStarredNotes => _notesRepo.getStarredNotes().length;
  int get totalArchivedNotes => _notesRepo.getArchivedNotes().length;

  String get userDisplayName => _mock.currentUser?.displayName ?? 'User';
  String get userUsername => _mock.currentUser?.username ?? '@user';
  String get userBio => _mock.currentUser?.bio ?? '';
  String get userInitials => _mock.currentUser?.initials ?? '?';
  int get avatarColorIndex => _mock.currentUser?.avatarColorIndex ?? 0;
  int get coverGradientIndex => _mock.currentUser?.coverGradientIndex ?? 0;

  bool get isCoverSolid => coverGradientIndex < 12;

  List<Color> get coverColors => isCoverSolid
      ? _coverSolidColors[coverGradientIndex % _coverSolidColors.length]
      : AppColors.coverGradients[(coverGradientIndex - 12) %
            AppColors.coverGradients.length];

  static const _coverSolidColors = [
    [Color(0xFF3B3BE8)],
    [Color(0xFF10B981)],
    [Color(0xFFF59E0B)],
    [Color(0xFFEF4444)],
    [Color(0xFF8B5CF6)],
    [Color(0xFFEC4899)],
    [Color(0xFF06B6D4)],
    [Color(0xFF84CC16)],
    [Color(0xFF1A1A2E)],
    [Color(0xFF2D1B00)],
    [Color(0xFF0F2027)],
    [Color(0xFF1C0A1A)],
  ];

  void setFilter(String filter) {
    currentFilter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void setArchiveSearchQuery(String query) {
    archiveSearchQuery = query;
    notifyListeners();
  }

  void setTab(int tab) {
    currentTab = tab;
    notifyListeners();
  }

  void openNote(String noteId) {
    Get.toNamed(AppRoutes.noteEditor, arguments: {'noteId': noteId});
  }

  void createNewNote() {
    Get.toNamed(AppRoutes.newNote, arguments: {'noteId': null});
  }

  void toggleStar(String noteId) {
    final note = _notesRepo.getNoteById(noteId);
    if (note != null) {
      _notesRepo.updateNote(noteId, {'starred': !note.starred});
      _mock.refreshNotes();
      notifyListeners();
    }
  }

  void togglePin(String noteId) {
    final note = _notesRepo.getNoteById(noteId);
    if (note != null) {
      _notesRepo.updateNote(noteId, {'pinned': !note.pinned});
      _mock.refreshNotes();
      notifyListeners();
    }
  }

  void toggleArchive(String noteId) {
    final note = _notesRepo.getNoteById(noteId);
    if (note != null) {
      _notesRepo.updateNote(noteId, {'archived': !note.archived});
      _mock.refreshNotes();
      notifyListeners();
    }
  }

  void duplicateNote(String noteId) {
    final note = _notesRepo.getNoteById(noteId);
    if (note != null) {
      _notesRepo.createNote(
        NoteModel(
          id: '',
          title: '${note.title} (copy)',
          deltaJson: List<dynamic>.from(note.deltaJson),
          tag: note.tag,
          starred: false,
          archived: false,
          pinned: false,
        ),
      );
      _mock.refreshNotes();
      notifyListeners();
    }
  }

  void deleteNote(String noteId) {
    _notesRepo.deleteNote(noteId);
    _mock.refreshNotes();
    notifyListeners();
  }

  void signOut() {
    selectedImagePath = null;
    _mock.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> pickProfileImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (image != null) {
        selectedImagePath = image.path;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void setAvatarColor(int index) {
    final user = _mock.currentUser;
    if (user != null) {
      user.avatarColorIndex = index;
      notifyListeners();
    }
  }
}
