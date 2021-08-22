import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/widgets/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistrationOTPPage extends StatefulWidget {
  final PageController pageController;
  const UserRegistrationOTPPage({
    this.pageController,
  });

  @override
  _UserRegistrationOTPPageState createState() => _UserRegistrationOTPPageState();
}

class _UserRegistrationOTPPageState extends State<UserRegistrationOTPPage> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _otpFieldController = TextEditingController();

  @override
  void dispose() {
    _otpFieldController.dispose();
    super.dispose();
  }

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
