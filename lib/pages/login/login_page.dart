// lib/pages/login/login_page.dart

import 'package:cheerpup/pages/login/riverpod/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _identifierFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isEmail = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _identifierFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Unfocus any active text fields
    _identifierFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    final identifier = _identifierController.text.trim();
    final password = _passwordController.text;

    // Validate inputs
    if (identifier.isEmpty || password.isEmpty) {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email/phone and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Call login method from the provider
    ref
        .read(loginProvider.notifier)
        .login(identifier: identifier, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    print(
      "Login page build - token: ${loginState.token}, isLoading: ${loginState.isLoading}",
    );

    // If login was successful and we have a token, navigate to home
    // In login_page.dart
    if (loginState.token != null && !loginState.isLoading) {
      print("Navigation condition met - redirecting to home");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) {
          print("Post-frame callback executing - attempting redirect to home");
          // Add small delay to ensure auth state is updated in GoRouter
          await Future.delayed(Duration(milliseconds: 150));

          // Force a NavigatorState.pop and then navigate to home
          if (context.mounted) {
            print("Executing navigation to home");
            // Use pushReplacement instead of go for more reliable navigation
            context.go('/');
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Unfocus active text fields when tapping outside
          _identifierFocusNode.unfocus();
          _passwordFocusNode.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // --- Header UI ---
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA9BC7D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.plus_one,
                        color: Color(0xFFA9BC7D),
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Sign in to Cheerpup',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3728),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Email/Phone ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email/Phone',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4A3728),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFA9BC7D),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _identifierController,
                          focusNode: _identifierFocusNode,
                          keyboardType:
                              _isEmail
                                  ? TextInputType.emailAddress
                                  : TextInputType.phone,
                          onTapOutside: (_) => _identifierFocusNode.unfocus(),
                          onChanged: (value) {
                            // Detect if user is typing an email or phone number
                            // This is only used to set the appropriate keyboard type
                            setState(() {
                              _isEmail = value.contains('@');
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter your email or phone number',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xFF4A3728),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4A3728),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFA9BC7D),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: true,
                          onTapOutside: (_) => _passwordFocusNode.unfocus(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF4A3728),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // password visibility toggle (optional)
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // --- Sign In Button ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: loginState.isLoading ? null : _handleLogin,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            loginState.isLoading
                                ? Colors.grey
                                : const Color(0xFF4A3728),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child:
                            loginState.isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Error message
                if (loginState.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      loginState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 16),

                // --- Sign Up Link ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFF4A3728), fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        context.replaceNamed('signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFFFF9500),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
