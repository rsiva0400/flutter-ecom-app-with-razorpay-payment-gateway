
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tshirt_design/app/components/custom_snackbar.dart';
import 'package:tshirt_design/app/modules/payout.dart';
import 'package:tshirt_design/app/modules/your_designs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/screen_title.dart';
import '../../subscribe_page.dart';
import 'widgets/settings_item.dart';
import 'package:tshirt_design/app/data/local/my_shared_pref.dart';



class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {


  bool _isSubscibed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isSubscibed = MySharedPref.getPremium()/**/;

  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
            ),
            20.verticalSpace,
            Text(
                'Profile',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                )
            ),
            20.verticalSpace,

            // Account
            GestureDetector(
              onTap: () {
                if(_isSubscibed){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyDesigns()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscribePage()));
                }
              },
              child: SettingsItem(
                title: _isSubscibed ? 'Start Designing' :'Become a Designer',
                icon: _isSubscibed ? Icons.design_services_sharp : Icons.account_circle_sharp,
              ),
            ),

            // Withdrawal button
            if(_isSubscibed)
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Payout()));
                },
                child: const SettingsItem(
                  title: 'My Earnings',
                  icon: Icons.monetization_on_sharp,
                ),
              ),
            30.verticalSpace,
            Text(
                'Settings',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                )
            ),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Icons.dark_mode_sharp,
              isDark: true,
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: (){
                if (_isSubscibed){
                  if (MySharedPref.getTotal() > 1){
                    CustomSnackBar.showCustomSnackBar(title: "Can't Proceed", message: "You have made few sales. Refund not possible.");
                  }else{
                    CustomSnackBar.showCustomSnackBar(title: "Please!", message: "Please wait for 3 days.");
                  }
                }else{
                  CustomSnackBar.showCustomErrorSnackBar(title: "Error", message: "You have not subscribed yet!!");
                }
              },
              child: const SettingsItem(
                title: 'Request Refund',
                icon: Icons.money_sharp,
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () async{
                await launchUrl(Uri.parse("mailto:support@shirtbazaar.in"));
              },
              child: const SettingsItem(
                title: 'Contact Us',
                icon: Icons.contact_phone_sharp,
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () async{
                await launchUrl(Uri.parse("https://www.freeprivacypolicy.com/live/c26f72f7-fd4b-4280-9b32-c97da9b8c5c7"));
              },
              child: const SettingsItem(
                title: 'Privacy Policy',
                icon: Icons.privacy_tip_sharp,
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}


