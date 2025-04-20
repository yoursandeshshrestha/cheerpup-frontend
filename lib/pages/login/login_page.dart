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
  bool _obscurePassword = true;

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
    _unfocusAll();

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

  void _unfocusAll() {
    _identifierFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    // If login was successful and we have a token, navigate to home
    if (loginState.token != null && !loginState.isLoading) {
      // Use addPostFrameCallback to avoid build-during-build errors
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) {
          // Add small delay to ensure auth state is updated in GoRouter
          await Future.delayed(const Duration(milliseconds: 150));

          if (context.mounted) {
            context.go('/');
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Match SignupPage background
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: _unfocusAll,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // --- Header UI ---
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF5D4037), // Dark brown from SignupPage
                        const Color(0xFF8D6E63), // Lighter brown variant
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.plus_one,
                        color: Color(0xFF5D4037), // Match header gradient
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Sign in to Cheerpup',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5D4037), // Match SignupPage text
                  ),
                ),
                const SizedBox(height: 40),

                // --- Form fields ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email/Phone field
                      Text(
                        'Email/Phone',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            0xFF5D4037,
                          ), // Match SignupPage text
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Rounder corners like SignupPage
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(
                              0xFFEADDD7,
                            ), // Light border from SignupPage
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
                              color: Color(
                                0xFF5D4037,
                              ), // Match SignupPage icons
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password field
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            0xFF5D4037,
                          ), // Match SignupPage text
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Rounder corners like SignupPage
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(
                              0xFFEADDD7,
                            ), // Light border from SignupPage
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: _obscurePassword,
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
                              color: Color(
                                0xFF5D4037,
                              ), // Match SignupPage icons
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Forgot Password
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       // Handle forgot password
                      //     },
                      //     child: Text(
                      //       'Forgot Password?',
                      //       style: TextStyle(
                      //         color: const Color(
                      //           0xFF1565C0,
                      //         ), // Blue from SignupPage
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                        gradient: LinearGradient(
                          colors: [
                            const Color(
                              0xFF5D4037,
                            ), // Dark brown from SignupPage
                            const Color(0xFF8D6E63), // Lighter brown variant
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // Match SignupPage
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5D4037).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
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
                                      'Sign in',
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

                // --- Error message ---
                if (loginState.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      loginState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: const Color(0xFF5D4037), // Match SignupPage text
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.replaceNamed('signup');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: const Color(
                            0xFF1565C0,
                          ), // Blue from SignupPage
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
