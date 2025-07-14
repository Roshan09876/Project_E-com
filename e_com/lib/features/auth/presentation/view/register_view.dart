import 'package:e_com/config/router/app_routes.dart';
import 'package:e_com/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final fullName = fullNameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ref.read(authViewModelProvider.notifier).register(
            name: fullName,
            email: email,
            password: password,
            context: context,
          );
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: fullNameController,
                          label: 'Full Name',
                          icon: Icons.person_outline,
                          validator: (value) =>
                              value!.isEmpty ? 'Full Name is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: emailController,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscureConfirmPassword,
                          validator: (value) => value!.isEmpty
                              ? 'Confirm Password is required'
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.loginRoute),
                      child: const Text("Already have an account? Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        suffixIcon: suffixIcon,
        labelText: label,
        floatingLabelStyle: const TextStyle(color: Colors.deepOrange),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange, width: 1.4),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
