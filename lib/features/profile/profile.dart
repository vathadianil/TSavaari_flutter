import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/authentication/controllers/login_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: const Text(
          'Profile',
        ),
        actions: [
          IconButton(
              onPressed: () {
                LoginController.instance.logout(context);
              },
              icon: const Icon(Iconsax.logout))
        ],
      ),
    );
  }
}
