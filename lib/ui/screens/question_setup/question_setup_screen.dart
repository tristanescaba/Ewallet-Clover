import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/question_setup/pages/question_setup_answer_page.dart';
import 'package:ewallet_clover/ui/screens/question_setup/pages/question_setup_otp_page.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionSetupScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    List<Widget> _pages = [
      if (user.mobileNumber == null) QuestionSetupOTPPage(pageController: _pageController),
      QuestionSetupAnswerPage(pageController: _pageController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Security Questions'),
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
