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
                    Divider(),
                    InformationTile(
                      title: 'First Name',
                      value: registration.firstName,
                    ),
                    Divider(),
                    if (registration.middleName != '')
                      Column(
                        children: [
                          InformationTile(
                            title: 'Middle Name',
                            value: registration.middleName,
                          ),
                          Divider(),
                        ],
                      ),
                    InformationTile(
                      title: 'Last Name',
                      value: registration.firstName,
                    ),
                    Divider(),
                    InformationTile(
                      title: 'Birth Date',
                      value: registration.birthDate,
                    ),
                    Divider(),
                    InformationTile(
                      title: 'Gender',
                      value: registration.gender,
                    ),
                    Divider(),
                    InformationTile(
                      title: 'Full Address',
                      value: registration.fullAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
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
    );
  }
}
