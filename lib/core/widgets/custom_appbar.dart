import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../config/app_colors.dart';
import '../db/prefs.dart';
import '../utils.dart';
import 'texts/text_r.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(this.title, {super.key, this.profile = false});

  final String title;
  final bool profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10 + getStatusBar(context),
        bottom: 10,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 40),
            Expanded(
              child: TextM(
                title,
                fontSize: 32,
                color: AppColors.text1,
              ),
            ),
            if (!profile)
              CupertinoButton(
                onPressed: () {
                  context.push('/profile');
                },
                padding: EdgeInsets.zero,
                minSize: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.file(
                    File(userImage),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/profile.png',
                        height: 50,
                        width: 50,
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
