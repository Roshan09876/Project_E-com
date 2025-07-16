import 'package:e_com/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authViewModelProvider.notifier).getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(authViewModelProvider);
    final data = profileState.profileData;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : data == null
          ? const Center(child: Text("Failed to load profile"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// 👤 Avatar and Name
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      data.name?.substring(0, 1).toUpperCase() ?? '?',
                      style: const TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data.name ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// 📧 Email
                  const SizedBox(height: 8),
                  Text(
                    data.email ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  /// 🏷 Role
                  Chip(
                    label: Text(
                      data.isAdmin == true ? "Admin" : "User",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: data.isAdmin == true
                        ? Colors.red
                        : Colors.green,
                  ),

                  const SizedBox(height: 24),

                  /// 🛒 Cart Summary
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: const Text("Cart Items"),
                      trailing: Text(
                        "${data.cartData?.length ?? 0}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// 🚪 Logout Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).logout(context);
                    },
                    icon: const Icon(Icons.logout, color: Colors.white,),
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
