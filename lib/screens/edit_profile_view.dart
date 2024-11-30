import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bookit/providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  late String email;

  @override
  void initState() {
    super.initState();
    // Initialize username and email from current profile state
    final profileState = ref.read(profileProvider);
    _usernameController.text = profileState.username ?? '';
    email = profileState.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                  onPressed: () {
                    // Save the updated username
                    if (_usernameController.text.isNotEmpty) {
                      ref.read(profileProvider.notifier).updateProfile(
                            username: _usernameController.text,
                            email: email,
                          );
                    }
                  },
                  child: Text('Save')),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
