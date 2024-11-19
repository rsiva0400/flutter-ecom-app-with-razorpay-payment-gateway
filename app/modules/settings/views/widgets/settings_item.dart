import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isAccount;
  final bool isDark;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      title: Text(title, style: theme.textTheme.displayMedium?.copyWith(
        fontSize: 16.sp,
      )),
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 25.r,
        backgroundColor: theme.primaryColor,
        child: Icon(icon, size: 28,),
      ),
      trailing: isDark
        ? GetBuilder<SettingsController>(
            id: 'Theme',
            builder: (controller) => CupertinoSwitch(
              value: !controller.isLightTheme,
              onChanged: controller.changeTheme,
              activeColor: theme.primaryColor,
            ),
          )
        : Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgPicture.asset(
              Constants.forwardArrowIcon,
              fit: BoxFit.none
            ),
          ),
    );
  }
}