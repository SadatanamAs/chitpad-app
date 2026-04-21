import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/providers/app_providers.dart';
import 'note_editor_controller.dart';

class _NoteEditorToolbar extends ConsumerWidget {
  final String? noteId;
  final dynamic colors;

  const _NoteEditorToolbar({required this.noteId, required this.colors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(noteEditorProvider(noteId));
    return ExcludeSemantics(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: QuillSimpleToolbar(
            controller: controller.quillController,
            config: QuillSimpleToolbarConfig(
              showAlignmentButtons: false,
              showDirection: false,
              showFontFamily: false,
              showFontSize: false,
              showInlineCode: true,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showLink: false,
              showSearchButton: false,
              showSubscript: false,
              showSuperscript: false,
              showIndent: false,
              showSmallButton: false,
              showRedo: false,
              showUndo: false,
              toolbarIconAlignment: WrapAlignment.start,
              iconTheme: QuillIconTheme(
                iconButtonSelectedData: IconButtonData(
                  color: Colors.white,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(colors.accent),
                  ),
                ),
                iconButtonUnselectedData: IconButtonData(
                  color: colors.text2,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(colors.card2),
                    side: WidgetStateProperty.all(
                      BorderSide(color: colors.border),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoteEditorView extends ConsumerWidget {
  const NoteEditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic>? args = Get.arguments;
    final String? noteId = args?['noteId'];

    final tc = ref.watch(themeProvider);
    final controller = ref.watch(noteEditorProvider(noteId));
    final colors = tc.colors;

    return Scaffold(
      backgroundColor: colors.card,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          controller.autoSaveThenGoBack();
        },
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              _buildTopBar(colors, controller),

              // Title + meta + editor
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Title input
                      TextField(
                        controller: controller.titleController,
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: colors.text,
                          letterSpacing: -0.3,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: GoogleFonts.nunito(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: colors.text3,
                          ),
                          border: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),

                      // Tag pills (for new note) or meta row
                      Builder(
                        builder: (_) {
                          if (controller.isNewNote) {
                            return _buildTagPills(colors, controller);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Text(
                                    '${controller.wordCount} words',
                                    style: GoogleFonts.dmMono(
                                      fontSize: 10.5,
                                      color: colors.text3,
                                    ),
                                  ),
                                  if (controller.selectedTag.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    _tagBadge(controller.selectedTag, colors),
                                  ],
                                ],
                              ),
                            );
                          }
                        },
                      ),

                      Divider(color: colors.border, height: 1),
                      const SizedBox(height: 8),

                      // Quill editor — the rich text area
                      Expanded(
                        child: RepaintBoundary(
                          child: ExcludeSemantics(
                            child: QuillEditor.basic(
                              controller: controller.quillController,
                              focusNode: controller.editorFocusNode,
                              scrollController:
                                  controller.editorScrollController,
                              config: QuillEditorConfig(
                                placeholder: 'Start writing…',
                                padding: const EdgeInsets.only(bottom: 80),
                                customStyles: DefaultStyles(
                                  paragraph: DefaultTextBlockStyle(
                                    GoogleFonts.nunito(
                                      fontSize: tc.noteFontSize,
                                      color: colors.text,
                                      height: 1.8,
                                    ),
                                    const HorizontalSpacing(0, 0),
                                    const VerticalSpacing(0, 0),
                                    const VerticalSpacing(0, 0),
                                    null,
                                  ),
                                  h1: DefaultTextBlockStyle(
                                    GoogleFonts.nunito(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: colors.text,
                                    ),
                                    const HorizontalSpacing(0, 0),
                                    const VerticalSpacing(8, 4),
                                    const VerticalSpacing(0, 0),
                                    null,
                                  ),
                                  h2: DefaultTextBlockStyle(
                                    GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: colors.text,
                                    ),
                                    const HorizontalSpacing(0, 0),
                                    const VerticalSpacing(6, 3),
                                    const VerticalSpacing(0, 0),
                                    null,
                                  ),
                                  h3: DefaultTextBlockStyle(
                                    GoogleFonts.nunito(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: colors.text,
                                    ),
                                    const HorizontalSpacing(0, 0),
                                    const VerticalSpacing(4, 2),
                                    const VerticalSpacing(0, 0),
                                    null,
                                  ),
                                  bold: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  italic: GoogleFonts.nunito(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  underline: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  strikeThrough: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  inlineCode: InlineCodeStyle(
                                    style: GoogleFonts.dmMono(
                                      fontSize: 13,
                                      color: colors.accent,
                                    ),
                                    backgroundColor: colors.accentLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Formatting toolbar
              _NoteEditorToolbar(noteId: noteId, colors: colors),

              // Word count bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
                color: colors.card,
                child: Text(
                  '${controller.wordCount} words · saved',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmMono(
                    fontSize: 10.5,
                    color: colors.text3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(dynamic colors, NoteEditorController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => controller.autoSaveThenGoBack(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: colors.card2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 14,
                color: colors.text2,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Title in center
          Expanded(
            child: Text(
              controller.title.isEmpty ? 'Untitled' : controller.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: colors.text,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Star button (only for existing notes)
          if (!controller.isNewNote)
            GestureDetector(
              onTap: controller.toggleStar,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colors.card2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  controller.isStarred ? Icons.star : Icons.star_border,
                  size: 18,
                  color: controller.isStarred ? colors.star : colors.text3,
                ),
              ),
            ),

          const SizedBox(width: 6),

          // Save button
          GestureDetector(
            onTap: controller.save,
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagPills(dynamic colors, NoteEditorController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TAG',
            style: GoogleFonts.dmMono(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: colors.text3,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _tagPill(
                'Work',
                colors.tagWorkBg,
                colors.tagWork,
                colors,
                controller,
              ),
              _tagPill(
                'Personal',
                colors.tagPersonalBg,
                colors.tagPersonal,
                colors,
                controller,
              ),
              _tagPill(
                'Ideas',
                colors.tagIdeasBg,
                colors.tagIdeas,
                colors,
                controller,
              ),
              _tagPill(
                '',
                colors.card2,
                colors.text3,
                colors,
                controller,
                label: 'None',
              ),
              _addCustomTagPill(colors, controller),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tagPill(
    String tag,
    Color bg,
    Color fg,
    dynamic colors,
    NoteEditorController controller, {
    String? label,
  }) {
    final isSelected = controller.selectedTag == tag;
    return GestureDetector(
      onTap: () => controller.setTag(tag),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? fg : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label ?? tag,
          style: GoogleFonts.nunito(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
      ),
    );
  }

  Widget _tagBadge(String tag, dynamic colors) {
    Color bg, fg;
    switch (tag) {
      case 'Work':
        bg = colors.tagWorkBg;
        fg = colors.tagWork;
        break;
      case 'Personal':
        bg = colors.tagPersonalBg;
        fg = colors.tagPersonal;
        break;
      case 'Ideas':
        bg = colors.tagIdeasBg;
        fg = colors.tagIdeas;
        break;
      default:
        bg = colors.card2;
        fg = colors.text3;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag,
        style: GoogleFonts.nunito(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  Widget _addCustomTagPill(dynamic colors, NoteEditorController controller) {
    return GestureDetector(
      onTap: () => _showCreateTagDialog(colors, controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: colors.card2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 14, color: colors.text3),
            const SizedBox(width: 4),
            Text(
              'Custom',
              style: GoogleFonts.nunito(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: colors.text3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTagDialog(dynamic colors, NoteEditorController controller) {
    final textController = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Create tag',
          style: GoogleFonts.nunito(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: colors.text,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
          decoration: InputDecoration(
            hintText: 'Tag name',
            hintStyle: GoogleFonts.nunito(fontSize: 14, color: colors.text3),
            filled: true,
            fillColor: colors.card2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors.border),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: colors.text3,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final tag = textController.text.trim();
              if (tag.isNotEmpty) {
                controller.setTag(tag);
                Get.back();
              }
            },
            child: Text(
              'Add',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: colors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
