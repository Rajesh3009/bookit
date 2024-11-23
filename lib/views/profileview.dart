import 'package:bookit/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profileState.profileImageUrl != null
                  ? NetworkImage(profileState.profileImageUrl!)
                  : null,
              child: profileState.profileImageUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 20),
            // Improved conditional rendering using ternary operator
            Text(
              profileState.isLoading
                  ? 'Loading...'
                  : profileState.error != null
                      ? 'Error: ${profileState.error}'
                      : profileState.username ?? 'No username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: profileState.error != null
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Handle help tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                final navigator = Navigator.of(context);
                try {
                  await FirebaseAuth.instance.signOut();
                  navigator.pushNamedAndRemoveUntil(
                    AppRoutes.authWrapper,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) { // More specific error handling
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to logout: ${e.message}'), // Use error message
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) { // Catch other exceptions
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to logout: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
