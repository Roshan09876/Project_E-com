import 'package:e_com/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomView extends ConsumerStatefulWidget {
  const BottomView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomViewState();
}

class _BottomViewState extends ConsumerState<BottomView> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      body: homeState.lstWidget[homeState.index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: GNav(
          gap: 8,
          selectedIndex: homeState.index,
          onTabChange: (index) {
            ref.read(homeViewModelProvider.notifier).onChangeIndex(index);
          },
          backgroundColor: Colors.white,
          color: Colors.grey[600],
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepOrange,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          tabBorderRadius: 16,
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.favorite, text: 'Favorite'),
            GButton(icon: Icons.person_outline, text: 'Profile'),
            GButton(icon: Icons.settings, text: 'Setting'),
          ],
        ),
      ),
    );
  }
}
