import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/ui/shared/widgets/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetMPINOTPPage extends StatefulWidget {
  final PageController pageController;
  const ResetMPINOTPPage({
    this.pageController,
  });

  @override
  _ResetMPINOTPPageState createState() => _ResetMPINOTPPageState();
}

class _ResetMPINOTPPageState extends State<ResetMPINOTPPage> {
  @override
  Widget build(BuildContext context) {
    final registration = Provider.of<RegistrationProvider>(context);

    return OTPView(
      mobileNumber: registration.mobileNumber,
      onSuccess: () async {
        widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
  }
}
