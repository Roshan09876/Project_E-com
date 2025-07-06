import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPageView extends ConsumerStatefulWidget {
  const SearchPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends ConsumerState<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        title: Text(
          'Search Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.brown.shade100),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for handmade products...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Color(0xFF8D6E63)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
