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

    // Fetch user profile after UI builds
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authViewModelProvider.notifier).getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state from AuthViewModel
    final authState = ref.watch(authViewModelProvider);
    final user = authState.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator(color: Colors.brown))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // ------------------ Profile Image ------------------
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.brown.shade200,
                      backgroundImage: user.image.isNotEmpty
                          ? NetworkImage(user.image)
                          : null,
                      child: user.image.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ------------------ Name & Username ------------------
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                      fontFamily: 'Georgia',
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    "@${user.userName}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------ Info Section ------------------
                  _buildProfileTile(
                    icon: Icons.email,
                    title: 'Email',
                    value: user.email ?? "N/A",
                  ),
                  _buildProfileTile(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: user.phoneNumber ?? "N/A",
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .logout(context);
                      },
                      child: const Icon(Icons.logout, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  // 🔹 Helper widget to show profile info in a Card
  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      shadowColor: Colors.brown.withOpacity(0.2),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6D4C41)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.brown,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }
}
