import 'package:bookit/routes/routes.dart';
import 'package:bookit/utils/upload_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_view.dart';

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
            if (profileState.isLoading)
              const CircularProgressIndicator()
            else if (profileState.error != null)
              Text(
                'Error: ${profileState.error}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )
            else
              Text(
                profileState.username ?? 'No username',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileView(),
                  ),
                );
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
                // Store context in local variable
                final navigator = Navigator.of(context);
                try {
                  await FirebaseAuth.instance.signOut();
                  navigator.pushNamedAndRemoveUntil(
                    AppRoutes.authWrapper,
                    (route) => false,
                  );
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to logout: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     DataUploader().uploadAllData();
            //   },
            //   child: const Text('Upload Data'),
            // ),
          ],
        ),
      ),
    );
  }
}
