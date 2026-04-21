import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/widgets/fox_mascot.dart';
import '../../../app/providers/app_providers.dart';

class ArchiveTab extends ConsumerWidget {
  const ArchiveTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(homeProvider);
    final colors = tc.colors;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Archive',
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: colors.text,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${controller.totalArchivedNotes} archived notes',
                  style: GoogleFonts.dmMono(
                    fontSize: 11.5,
                    color: colors.text3,
                  ),
                ),
              ],
            ),
          ),

          // Search
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: colors.card2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border),
            ),
            child: TextField(
              onChanged: controller.setArchiveSearchQuery,
              style: GoogleFonts.nunito(fontSize: 13.5, color: colors.text),
              decoration: InputDecoration(
                hintText: 'Search archived…',
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

          Expanded(
            child: Builder(
              builder: (_) {
                final notes = controller.archivedNotes;
                return notes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FoxMascot(size: 90, mood: FoxMood.idle),
                            const SizedBox(height: 12),
                            Text(
                              'Archive is empty',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colors.text3,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                        itemCount: notes.length,
                        itemBuilder: (_, i) {
                          final note = notes[i];
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
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunito(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w700,
                                            color: colors.text,
                                          ),
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
                                        Text(
                                          note.dateLabel,
                                          style: GoogleFonts.dmMono(
                                            fontSize: 10.5,
                                            color: colors.text3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.unarchive_outlined,
                                      size: 20,
                                      color: colors.text3,
                                    ),
                                    onPressed: () =>
                                        controller.toggleArchive(note.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
