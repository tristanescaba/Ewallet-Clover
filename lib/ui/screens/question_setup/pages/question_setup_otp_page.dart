import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/widgets/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionSetupOTPPage extends StatelessWidget {
  final PageController pageController;
  const QuestionSetupOTPPage({
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return OTPView(
      mobileNumber: user.savedMobileNumber,
      onSuccess: () async {
        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
  }
}
