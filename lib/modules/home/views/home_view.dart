import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers/app_providers.dart';
import 'notes_tab.dart';
import 'archive_tab.dart';
import 'profile_tab.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(homeProvider);
    final colors = tc.colors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: IndexedStack(
        index: controller.currentTab,
        children: const [NotesTab(), ArchiveTab(), ProfileTab()],
      ),
      floatingActionButton: controller.currentTab == 0
          ? FloatingActionButton(
              onPressed: controller.createNewNote,
              backgroundColor: colors.accent,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : const SizedBox.shrink(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.border, width: 1)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _NavItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Notes',
                  isActive: controller.currentTab == 0,
                  colors: colors,
                  onTap: () => controller.setTab(0),
                ),
                _NavItem(
                  icon: Icons.archive_outlined,
                  label: 'Archive',
                  isActive: controller.currentTab == 1,
                  colors: colors,
                  onTap: () => controller.setTab(1),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  isActive: controller.currentTab == 2,
                  colors: colors,
                  onTap: () => controller.setTab(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final dynamic colors;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? colors.accent : colors.text3,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isActive ? colors.accent : colors.text3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
