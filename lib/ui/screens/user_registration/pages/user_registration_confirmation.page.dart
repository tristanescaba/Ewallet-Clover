import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistrationConfirmationPage extends StatelessWidget {
  final PageController pageController;
  const UserRegistrationConfirmationPage({
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final registration = Provider.of<RegistrationProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Column(
                  children: [
                    InformationTile(
                      title: 'Mobile Number',
                      value: registration.mobileNumber,
                    ),
                    InformationTile(
                      title: 'Email Address',
                      value: registration.email,
                    ),
                    InformationTile(
                      title: 'First Name',
                      value: registration.firstName,
                    ),
                    if (registration.middleName != '')
                      Column(
                        children: [
                          InformationTile(
                            title: 'Middle Name',
                            value: registration.middleName,
                          ),
                        ],
                      ),
                    InformationTile(
                      title: 'Last Name',
                      value: registration.lastName,
                    ),
                    InformationTile(
                      title: 'Birth Date',
                      value: registration.birthDate,
                    ),
                    InformationTile(
                      title: 'Gender',
                      value: registration.gender,
                    ),
                    InformationTile(
                      title: 'Full Address',
                      value: registration.fullAddress,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    child: GradientButton(
                      title: 'Back',
                      hasBorder: true,
                      onPressed: () {
                        pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 50.0,
                    child: GradientButton(
                      title: 'Confirm',
                      onPressed: () {
                        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
