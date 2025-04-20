import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/profile_button.dart';
import 'widgets/profile_field.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_weight_slider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  late double _weightValue;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homePageProvider);
    final user = homeState.currentUser;
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title
                const ProfileHeader(title: "Profile Setup"),

                // Profile image
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(color: Colors.white, width: 2),
                          image:
                              user?.profileImage != null
                                  ? DecorationImage(
                                    image: NetworkImage(user!.profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                        ),
                        child:
                            user?.profileImage == null
                                ? const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                                : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6E4626),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Form fields
                const SizedBox(height: 20),
                ProfileField(
                  label: "Full Name",
                  controller: _nameController,
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 16),
                ProfileField(
                  label: "Email Address",
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),
                const Text(
                  "Account Type",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20),

                ProfileWeightSlider(
                  value: _weightValue,
                  onChanged: (value) {
                    setState(() {
                      _weightValue = value;
                    });
                  },
                  min: 30,
                  max: 150,
                ),
                const SizedBox(height: 20),

                // ProfileDropdownField(
                //   label: "Gender",
                //   value: _selectedGender,
                //   icon: Icons.transgender,
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         _selectedGender = value;
                //       });
                //     }
                //   },
                //   items: const [
                //     "Male",
                //     "Female",
                //     "Trans Male",
                //     "Trans Female",
                //     "Non-Binary",
                //     "Other",
                //   ],
                // ),
                const SizedBox(height: 16),

                // ProfileDropdownField(
                //   label: "Location",
                //   value: _selectedLocation,
                //   icon: Icons.location_on_outlined,
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         _selectedLocation = value;
                //       });
                //     }
                //   },
                //   items: const [
                //     "Tokyo, Japan",
                //     "New York, USA",
                //     "London, UK",
                //     "Paris, France",
                //     "Sydney, Australia",
                //   ],
                // ),
                const SizedBox(height: 30),
                ProfileButton(
                  label: "Save Changes",
                  onPressed: () {
                    _handleSubmit();
                  },
                ),

                const SizedBox(height: 30),
                GestureDetector(
                  child: Text("Logout"),
                  onTap: () async {
                    await ref.read(authServiceProvider).logout();

                    // Wait to ensure the auth state change is processed
                    await Future.delayed(Duration(milliseconds: 200));

                    if (context.mounted) {
                      // Verify the auth state before navigating
                      final isStillLoggedIn =
                          await ref.read(authServiceProvider).isAuthenticated();
                      print(
                        "Before navigation: isStillLoggedIn = $isStillLoggedIn",
                      );

                      if (!isStillLoggedIn && context.mounted) {
                        print("Navigation to login is safe now");
                        context.go('/login');
                      } else {
                        print("WARNING: Still logged in after logout attempt!");
                        // Force a second logout attempt if still logged in
                        await ref.read(authServiceProvider).logout();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    // Validate form fields
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Update the user profile in the provider
    final notifier = ref.read(homePageProvider.notifier);
    notifier.updateUserProfile(
      name: _nameController.text,
      email: _emailController.text,
      weight: _weightValue,
      // gender: _selectedGender,
      // location: _selectedLocation,
    );

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    // Navigate back to the home screen
    context.go('/');
  }
}
