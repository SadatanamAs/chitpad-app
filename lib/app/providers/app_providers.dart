import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/mock_data_service.dart';
import '../../data/repositories/notes_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../theme/app_theme.dart';
import '../../modules/auth/auth_controller.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/settings/settings_controller.dart';
import '../../modules/note_editor/note_editor_controller.dart';

// Core data
final mockDataServiceProvider = Provider<MockDataService>(
  (ref) => MockDataService(),
);
final notesRepositoryProvider = Provider<NotesRepository>(
  (ref) => NotesRepository(ref),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref),
);

// Feature state
final themeProvider = ChangeNotifierProvider<ThemeController>(
  (ref) => ThemeController(),
);
final authProvider = ChangeNotifierProvider<AuthController>(
  (ref) => AuthController(ref),
);
final homeProvider = ChangeNotifierProvider<HomeController>(
  (ref) => HomeController(ref),
);
final settingsProvider = ChangeNotifierProvider<SettingsController>(
  (ref) => SettingsController(ref),
);
final noteEditorProvider = ChangeNotifierProvider.autoDispose
    .family<NoteEditorController, String?>(
      (ref, noteId) => NoteEditorController(ref, noteId),
    );
