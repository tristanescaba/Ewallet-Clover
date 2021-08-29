import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/reset_mpin/pages/reset_mpin_new_page.dart';
import 'package:ewallet_clover/ui/screens/reset_mpin/pages/reset_mpin_otp_page.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetMPINScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    List<Widget> _pages = [
      ResetMPINNewPage(pageController: _pageController),
      ResetMPINOTPPage(pageController: _pageController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(user.mobileNumber == null ? 'Forgot MPIN' : 'Change MPIN'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
