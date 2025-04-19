import 'package:cheerpup/pages/login/riverpod/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    // Unfocus any active text fields
    _focusNode1.unfocus();
    _focusNode2.unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    ref.read(signInProvider.notifier).signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Unfocus active text fields when tapping outside
          _focusNode1.unfocus();
          _focusNode2.unfocus();
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
                  'Sign up to Cheerpup',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3728),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Email ---
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
                          controller: _emailController,
                          focusNode: _focusNode1,
                          onTapOutside: (_) => _focusNode1.unfocus(),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter your email/Phone...',
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
                          focusNode: _focusNode2,
                          obscureText: true,
                          onTapOutside: (_) => _focusNode2.unfocus(),
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

                      const SizedBox(height: 20),

                      const Text(
                        'Confirm password',
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
                          focusNode: _focusNode2,
                          obscureText: true,
                          onTapOutside: (_) => _focusNode2.unfocus(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm your password',
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
                    onTap: signInState.isLoading ? null : _handleSignIn,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            signInState.isLoading
                                ? Colors.grey
                                : const Color(0xFF4A3728),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child:
                            signInState.isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Sign up',
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

                if (signInState.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      signInState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 30),

                // // --- Social Login ---
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _socialLoginButton(Icons.facebook, const Color(0xFF4A3728)),
                //     const SizedBox(width: 20),
                //     _socialLoginButton(
                //       Icons.g_mobiledata,
                //       const Color(0xFF4A3728),
                //     ),
                //     const SizedBox(width: 20),
                //     _socialLoginButton(
                //       Icons.camera_alt_outlined,
                //       const Color(0xFF4A3728),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFF4A3728), fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        context.replaceNamed('login');
                      },
                      child: const Text(
                        'Sign in',
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

  Widget _socialLoginButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Icon(icon, color: color),
    );
  }
}
