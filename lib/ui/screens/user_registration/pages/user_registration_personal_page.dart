import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistrationPersonalPage extends StatefulWidget {
  final PageController pageController;

  const UserRegistrationPersonalPage({this.pageController});

  @override
  _UserRegistrationPersonalPageState createState() => _UserRegistrationPersonalPageState();
}

class _UserRegistrationPersonalPageState extends State<UserRegistrationPersonalPage> {
  final _formKey = GlobalKey<FormState>();
  final _firsNameFieldController = TextEditingController();
  final _middleNameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _birthDateFieldController = TextEditingController();
  final _genderFieldController = TextEditingController();
  final _maritalStatusFieldController = TextEditingController();
  final _addressFieldController = TextEditingController();

  @override
  void dispose() {
    _firsNameFieldController.dispose();
    _middleNameFieldController.dispose();
    _lastNameFieldController.dispose();
    _birthDateFieldController.dispose();
    _genderFieldController.dispose();
    _maritalStatusFieldController.dispose();
    _addressFieldController.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        title: 'First Name',
                        controller: _firsNameFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input your first name.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Middle Name',
                        hintText: '(Optional)',
                        controller: _middleNameFieldController,
                      ),
                      MyTextField(
                        title: 'Last Name',
                        controller: _lastNameFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input your last name.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Birthdate',
                        controller: _birthDateFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please select your birth date.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Gender',
                        controller: _genderFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please choose your gender.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Marital Status',
                        controller: _maritalStatusFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please choose your marital status.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Full Address',
                        controller: _addressFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input your full address.";
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Container(
              height: 50.0,
              child: GradientButton(
                title: 'Next',
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    registration.firstName = '${_firsNameFieldController.text}';
                    registration.middleName = '${_middleNameFieldController.text}';
                    registration.lastName = '${_lastNameFieldController.text}';
                    registration.birthDate = '${_birthDateFieldController.text}';
                    registration.gender = '${_genderFieldController.text}';
                    registration.maritalStatus = '${_maritalStatusFieldController.text}';
                    registration.fullAddress = '${_addressFieldController.text}';
                    widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
