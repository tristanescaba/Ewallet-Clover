import 'package:ewallet_clover/ui/screens/user_registration/pages/user_registration_confirmation.page.dart';
import 'package:ewallet_clover/ui/screens/user_registration/pages/user_registration_mobilenum_page.dart';
import 'package:ewallet_clover/ui/screens/user_registration/pages/user_registration_mpin_page.dart';
import 'package:ewallet_clover/ui/screens/user_registration/pages/user_registration_otp_page.dart';
import 'package:ewallet_clover/ui/screens/user_registration/pages/user_registration_personal_page.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/page_step_view.dart';
import 'package:flutter/material.dart';

class UserRegistrationScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      UserRegistrationMobileNumPage(pageController: _pageController),
      UserRegistrationOTPPage(pageController: _pageController),
      UserRegistrationPersonalPage(pageController: _pageController),
      UserRegistrationConfirmationPage(pageController: _pageController),
      UserRegistrationMPINPage(pageController: _pageController),
    ];
    List<String> _pageTitles = [
      'Step 1: Input your mobile number.',
      'Step 2: Input OTP code sent to your mobile number.',
      'Step 3: Input your personal information.',
      'Step 4: Please confirm your inputted information.',
      'Step 5: Setup MPIN',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: PageStepView(
        pages: _pages,
        pageTitles: _pageTitles,
        pageController: _pageController,
      ),
    );
  }
}
