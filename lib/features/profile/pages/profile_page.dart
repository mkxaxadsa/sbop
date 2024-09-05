import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/db/prefs.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../../../core/widgets/texts/text_r.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  ImagePicker picker = ImagePicker();
  XFile image = XFile('');

  Future<XFile> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return XFile('');
      return image;
    } catch (e) {
      log(e.toString());
      return XFile('');
    }
  }

  void onPickImage() async {
    image = await pickImage();
    if (image.path.isNotEmpty) {
      await saveProfileImage(image.path);
      setState(() {});
    }
  }

  void onSave() async {
    await saveProfile(
      controller1.text,
      controller2.text,
      controller3.text,
      controller4.text,
    ).then((_) {
      context.pop();
    });
  }

  void onBack() {
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    controller1.text = userName;
    controller2.text = userSurname;
    controller3.text = userNickname;
    controller4.text = userBirthday;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resize: true,
      body: Column(
        children: [
          const CustomAppbar('Profile', profile: true),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              children: [
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 130,
                    width: 130,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: userImage.isEmpty
                              ? Image.asset(
                                  'assets/profile.png',
                                  height: 120,
                                  width: 120,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.file(
                                    File(userImage),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/profile.png',
                                        height: 120,
                                        width: 120,
                                      );
                                    },
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CupertinoButton(
                            onPressed: onPickImage,
                            padding: EdgeInsets.zero,
                            minSize: 20,
                            child: TextB(
                              '+',
                              fontSize: 32,
                              color: AppColors.white40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextM(
                  userName.isEmpty ? 'User' : userName,
                  fontSize: 32,
                  center: true,
                ),
                const SizedBox(height: 32),
                TxtField(
                  controller: controller1,
                  hintText: 'First name',
                  onChanged: () {},
                ),
                const SizedBox(height: 24),
                TxtField(
                  controller: controller2,
                  hintText: 'Last name',
                  onChanged: () {},
                ),
                const SizedBox(height: 24),
                TxtField(
                  controller: controller3,
                  hintText: 'Nickname',
                  onChanged: () {},
                ),
                const SizedBox(height: 24),
                TxtField(
                  controller: controller4,
                  hintText: 'Birthday (00.00.0000)',
                  number: true,
                  date: true,
                  onChanged: () {},
                ),
                const SizedBox(height: 86),
                Center(
                  child: PrimaryButton(
                    title: 'Save',
                    white: true,
                    width: 190,
                    onPressed: onSave,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: PrimaryButton(
                    title: 'Back',
                    white: true,
                    width: 190,
                    onPressed: onBack,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
