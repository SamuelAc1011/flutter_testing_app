import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

// Class -> ProfileScreen
/// A screen that displays the user's profile.
@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile App'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
