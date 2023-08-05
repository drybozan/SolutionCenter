import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/user_controller.dart';
import 'package:soltion_center/models/profile_model.dart';
import 'package:soltion_center/models/user_model.dart';
import 'package:soltion_center/units/logo.dart';

part 'profile_header.dart';

part 'profile_body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();
    final userController = Provider.of<UserController>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.profile!),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              userController.logoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),

        ],
      ),
      body: const Column(
        children: [
          ProfileHeader(),
          SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 2,
            child: ProfileBody(),
          ),
        ],
      ),
    );
  }
}
