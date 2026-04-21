import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/widgets/fox_mascot.dart';
import '../../../data/models/note_model.dart';
import '../home_controller.dart';

class NotesTab extends ConsumerWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(homeProvider);
    final colors = tc.colors;

    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My notes',
                      style: GoogleFonts.nunito(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: colors.text,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${controller.totalActiveNotes} notes · ${controller.totalStarredNotes} starred',
                      style: GoogleFonts.dmMono(
                        fontSize: 11.5,
                        color: colors.text3,
                      ),
                    ),
                  ],
                ),
                _ThemeButton(colors: colors, ref: ref),
              ],
            ),
          ),

          // Search bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: colors.card2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border),
            ),
            child: TextField(
              onChanged: controller.setSearchQuery,
              style: GoogleFonts.nunito(fontSize: 13.5, color: colors.text),
              decoration: InputDecoration(
                hintText: 'Search notes…',
                hintStyle: GoogleFonts.nunito(
                  fontSize: 13.5,
                  color: colors.text3,
                ),
                prefixIcon: Icon(Icons.search, size: 18, color: colors.text3),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Filter chips
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: ['All', 'Starred', 'Work', 'Personal', 'Ideas'].map((
                f,
              ) {
                final isOn = controller.currentFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => controller.setFilter(f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isOn ? colors.accent : colors.card2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        f,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isOn ? Colors.white : colors.text2,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),

          // Note list
          Expanded(
            child: Builder(
              builder: (_) {
                final notes = controller.activeNotes;
                return notes.isEmpty
                    ? _EmptyState(
                        colors: colors,
                        hasSearch: controller.searchQuery.isNotEmpty,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                        itemCount: notes.length,
                        itemBuilder: (_, i) => _NoteCard(
                          note: notes[i],
                          colors: colors,
                          controller: controller,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final dynamic colors;
  final WidgetRef ref;
  const _ThemeButton({required this.colors, required this.ref});

  @override
  Widget build(BuildContext context) {
    final tc = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () => _showThemeSheet(context, tc, colors),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: colors.card2,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.border),
        ),
        child: const Center(child: Text('🎨', style: TextStyle(fontSize: 16))),
      ),
    );
  }

  void _showThemeSheet(
    BuildContext context,
    ThemeController tc,
    dynamic colors,
  ) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Choose theme',
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: colors.text,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: ThemeController.allThemeIds.map((id) {
                final scheme = AppColors.getScheme(id);
                final isSelected = tc.currentThemeId == id;
                return GestureDetector(
                  onTap: () {
                    tc.setTheme(id);
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? colors.accent : colors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(color: scheme.bg),
                                      ),
                                      Expanded(
                                        child: Container(color: scheme.bg2),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(color: scheme.accent),
                                      ),
                                      Expanded(
                                        child: Container(color: scheme.text),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          scheme.label,
                          style: GoogleFonts.dmMono(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteModel note;
  final dynamic colors;
  final HomeController controller;

  const _NoteCard({
    required this.note,
    required this.colors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openNote(note.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (note.starred)
                        Container(
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.star,
                          ),
                        ),
                      if (note.pinned)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text('📌', style: TextStyle(fontSize: 10)),
                        ),
                      Expanded(
                        child: Text(
                          note.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: colors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    note.preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 12.5,
                      color: colors.text2,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        note.dateLabel,
                        style: GoogleFonts.dmMono(
                          fontSize: 10.5,
                          color: colors.text3,
                        ),
                      ),
                      if (note.tag.isNotEmpty) ...[
                        const SizedBox(width: 7),
                        _TagBadge(tag: note.tag, colors: colors),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _showNoteMenu(context, note),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: colors.border),
                  color: colors.card2,
                ),
                child: Center(
                  child: Text(
                    '···',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.text3,
                      letterSpacing: 1.5,
                      height: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoteMenu(BuildContext context, NoteModel note) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Text(
                note.title,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colors.text,
                ),
              ),
            ),
            Divider(height: 1, color: colors.border),
            _MenuItem(
              icon: Icons.push_pin_outlined,
              label: note.pinned ? 'Unpin' : 'Pin to top',
              bgColor: colors.accentLight,
              iconColor: colors.accent,
              onTap: () {
                controller.togglePin(note.id);
                Get.back();
              },
            ),
            _MenuItem(
              icon: Icons.star_border_rounded,
              label: note.starred ? 'Remove from starred' : 'Add to starred',
              bgColor: const Color(0xFFFEF3C7),
              iconColor: colors.star,
              onTap: () {
                controller.toggleStar(note.id);
                Get.back();
              },
            ),
            _MenuItem(
              icon: Icons.archive_outlined,
              label: note.archived ? 'Unarchive' : 'Archive',
              bgColor: colors.tagWorkBg,
              iconColor: colors.tagWork,
              onTap: () {
                controller.toggleArchive(note.id);
                Get.back();
              },
            ),
            _MenuItem(
              icon: Icons.copy_rounded,
              label: 'Duplicate',
              bgColor: colors.tagIdeasBg,
              iconColor: colors.tagIdeas,
              onTap: () {
                controller.duplicateNote(note.id);
                Get.back();
              },
            ),
            _MenuItem(
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              isDestructive: true,
              bgColor: colors.dangerBg,
              iconColor: colors.danger,
              onTap: () {
                controller.deleteNote(note.id);
                Get.back();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDestructive ? iconColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  final String tag;
  final dynamic colors;
  const _TagBadge({required this.tag, required this.colors});

  @override
  Widget build(BuildContext context) {
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
}

class _EmptyState extends StatelessWidget {
  final dynamic colors;
  final bool hasSearch;
  const _EmptyState({required this.colors, required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FoxMascot(
            size: 100,
            mood: hasSearch ? FoxMood.thinking : FoxMood.sad,
          ),
          const SizedBox(height: 16),
          Text(
            hasSearch ? 'No results found' : 'No notes yet — tap + to start',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.text3,
            ),
          ),
        ],
      ),
    );
  }
}
