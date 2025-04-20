import 'package:cheerpup/commons/models/dto/update_user_dto.dart';
import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/commons/services/user_service.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/profile_button.dart';
import 'widgets/profile_field.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;

  late double _weightValue;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    _weightValue = 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the user data from the provider
    final homeState = ref.read(homePageProvider);
    final user = homeState.currentUser;

    if (user != null) {
      // Update controllers with user data
      _nameController.text = user.name;
      _emailController.text = user.email;
      _weightValue = user.weight.toDouble();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _unfocusAll() {
    _nameFocusNode.unfocus();
    _emailFocusNode.unfocus();
  }

  Future<void> _handleSubmit() async {
    // Unfocus all fields
    _unfocusAll();

    setState(() {
      _isLoading = true;
    });

    // Validate form fields
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Get the current user from the provider
      final homeState = ref.read(homePageProvider);
      final user = homeState.currentUser;

      if (user == null) {
        throw Exception('User not found');
      }

      // Create UpdateUserDto with the new values
      final updateUserDto = UpdateUserDto(
        name: _nameController.text != user.name ? _nameController.text : null,
        email:
            _emailController.text != user.email ? _emailController.text : null,
        weight: _weightValue != user.weight ? _weightValue.toInt() : null,
        // Add other fields as needed
      );

      // Only call the API if there are changes
      if (!updateUserDto.isEmpty) {
        // Get an instance of UserService
        final userService = UserService();

        // Call the API to update the user
        final result = await userService.updateUser(
          user.id, // Assuming user.id contains the user ID
          updateUserDto,
        );

        if (!result['success']) {
          throw Exception(result['message'] ?? 'Failed to update profile');
        }
      }

      // Update the user profile in the provider
      final notifier = ref.read(homePageProvider.notifier);
      notifier.updateUserProfile(
        name: _nameController.text,
        email: _emailController.text,
        weight: _weightValue,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Color(0xFF5D4037),
          ),
        );

        setState(() {
          _isLoading = false;
        });

        // Navigate back to the home screen
        context.go('/');
        ref.read(navigationIndexProvider.notifier).state = 0;
      }
    } catch (e) {
      if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homePageProvider);
    final user = homeState.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Match SignupPage background
      body: GestureDetector(
        onTap: _unfocusAll,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header gradient
                Container(
                  width: double.infinity,
                  height: 150,
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
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.goNamed('home');
                            ref.read(navigationIndexProvider.notifier).state =
                                0;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF5D4037),
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          "Profile Setup",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Profile image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image:
                                    user?.profileImage != null
                                        ? DecorationImage(
                                          image: NetworkImage(
                                            user!.profileImage!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                        : null,
                              ),
                              child:
                                  user?.profileImage == null
                                      ? const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Color(0xFF5D4037),
                                          size: 40,
                                        ),
                                      )
                                      : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap:
                                    _handleImageUpload, // Add this onTap handler
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF5D4037),
                                        const Color(0xFF8D6E63),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Form fields
                      ProfileField(
                        label: "Full Name",
                        controller: _nameController,
                        icon: Icons.person_outline,
                        focusNode: _nameFocusNode,
                      ),

                      const SizedBox(height: 16),
                      ProfileField(
                        label: "Email Address",
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                      ),

                      // const SizedBox(height: 20),

                      // ProfileWeightSlider(
                      //   value: _weightValue,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _weightValue = value;
                      //     });
                      //   },
                      //   min: 30,
                      //   max: 150,
                      // ),
                      const SizedBox(height: 30),
                      ProfileButton(
                        label: "Save Changes",
                        icon: Icons.check,
                        isLoading: _isLoading,
                        onPressed: () {
                          _handleSubmit();
                        },
                      ),

                      const SizedBox(height: 30),
                      Center(
                        child: GestureDetector(
                          onTap: _handleLogout,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFFEADDD7),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Color(0xFF5D4037),
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Color(0xFF5D4037),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authServiceProvider).logout();

      // Wait to ensure the auth state change is processed
      await Future.delayed(const Duration(milliseconds: 200));

      if (context.mounted) {
        // Verify the auth state before navigating
        final isStillLoggedIn =
            await ref.read(authServiceProvider).isAuthenticated();

        if (!isStillLoggedIn && context.mounted) {
          context.go('/login');
        } else {
          // Force a second logout attempt if still logged in
          await ref.read(authServiceProvider).logout();
          if (context.mounted) {
            context.go('/login');
          }
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleImageUpload() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image == null) return; // User canceled the picker

      setState(() {
        _isLoading = true;
      });

      // Get user from provider
      final homeState = ref.read(homePageProvider);
      final user = homeState.currentUser;

      if (user == null) {
        throw Exception('User not found');
      }

      // Upload the image
      final userService = UserService();
      final result = await userService.uploadProfileImage(user.id, image.path);

      if (!result['success']) {
        throw Exception(result['message'] ?? 'Failed to upload image');
      }

      // Get the image URL from the response
      final String? imageUrl = result['data']['user']['profileImage'];

      if (imageUrl == null) {
        throw Exception('Image URL not found in response');
      }

      // Update the user profile in the provider
      final notifier = ref.read(homePageProvider.notifier);
      notifier.updateUserProfileImage(imageUrl);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile image updated successfully'),
            backgroundColor: Color(0xFF5D4037),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
