import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dropdown_field.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserRegistrationPersonalPage extends StatefulWidget {
  final PageController pageController;

  const UserRegistrationPersonalPage({this.pageController});

  @override
  _UserRegistrationPersonalPageState createState() => _UserRegistrationPersonalPageState();
}

class _UserRegistrationPersonalPageState extends State<UserRegistrationPersonalPage> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _firsNameFieldController = TextEditingController();
  final _middleNameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _birthDateFieldController = TextEditingController();
  final _addressFieldController = TextEditingController();

  @override
  void dispose() {
    _emailFieldController.dispose();
    _firsNameFieldController.dispose();
    _middleNameFieldController.dispose();
    _lastNameFieldController.dispose();
    _birthDateFieldController.dispose();
    _addressFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);
    DateTime selectedDate = DateTime.now();
    final f = new DateFormat('dd-MM-yyyy');

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1850, 1),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          _birthDateFieldController.text = f.format(picked); // picked.toString().split(' ')[0];
        });
    }

    String capitalizedEachWord(String text) {
      String inCaps(String text) {
        return text.length > 0 ? '${text[0].toUpperCase()}${text.substring(1)}' : '';
      }

      return text.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => inCaps(str)).join(" ");
    }

    Future<bool> checkEmail() async {
      loadingDialog.show();
      ResponseModel response = await _apiService.checkEmail(email: _emailFieldController.text);

      if (response.resultCode == 00) {
        loadingDialog.hide();
        return true;
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
            hasError: response.hasError,
          ),
        );
        return false;
      }
    }

    return StateWrapper(
      initState: () {
        if (registration.email != null) {
          _emailFieldController.text = registration.email;
        }
        if (registration.firstName != null) {
          _firsNameFieldController.text = registration.firstName;
        }
        if (registration.middleName != null) {
          _middleNameFieldController.text = registration.middleName;
        }
        if (registration.lastName != null) {
          _lastNameFieldController.text = registration.lastName;
        }
        if (registration.birthDate != null) {
          _birthDateFieldController.text = registration.birthDate;
        }
        if (registration.fullAddress != null) {
          _addressFieldController.text = registration.fullAddress;
        }
      },
      child: SafeArea(
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
                          title: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailFieldController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please input your email adress.";
                            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                              return "Invalid email format";
                            }
                          },
                        ),
                        MyTextField(
                          title: 'First Name',
                          denySpacing: false,
                          controller: _firsNameFieldController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please input your first name.";
                            }
                          },
                        ),
                        MyTextField(
                          title: 'Middle Name',
                          denySpacing: false,
                          textInputAction: TextInputAction.next,
                          hintText: '(Optional)',
                          controller: _middleNameFieldController,
                        ),
                        MyTextField(
                          title: 'Last Name',
                          denySpacing: false,
                          textInputAction: TextInputAction.next,
                          controller: _lastNameFieldController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please input your last name.";
                            }
                          },
                        ),
                        MyTextField(
                          title: 'Birth Date',
                          enableInteractiveSelection: false,
                          controller: _birthDateFieldController,
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please select your birth date.";
                            }
                          },
                        ),
                        MyDropdownField(
                          title: 'Gender',
                          selectedValue: registration.gender,
                          options: ['Male', 'Female'],
                          onChanged: (value) {
                            registration.gender = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose your gender.";
                            }
                          },
                        ),
                        MyDropdownField(
                          title: 'Marital Status',
                          selectedValue: registration.maritalStatus,
                          options: ['Single', 'Married', 'Divorced', 'Widowed'],
                          onChanged: (value) {
                            registration.maritalStatus = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose your marital status.";
                            }
                          },
                        ),
                        MyTextField(
                          title: 'Full Address',
                          controller: _addressFieldController,
                          textInputAction: TextInputAction.done,
                          denySpacing: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please input your full address.";
                            }
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState.validate()) {
                              registration.firstName = '${_firsNameFieldController.text}';
                              registration.middleName = '${_middleNameFieldController.text}';
                              registration.lastName = '${_lastNameFieldController.text}';
                              registration.birthDate = '${_birthDateFieldController.text}';
                              registration.fullAddress = '${_addressFieldController.text}';
                              widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
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
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState.validate()) {
                      if (await checkEmail()) {
                        registration.email = '${_emailFieldController.text}';
                        registration.firstName = capitalizedEachWord('${_firsNameFieldController.text}');
                        registration.middleName = capitalizedEachWord('${_middleNameFieldController.text}');
                        registration.lastName = capitalizedEachWord('${_lastNameFieldController.text}');
                        registration.birthDate = '${_birthDateFieldController.text}';
                        registration.fullAddress = '${_addressFieldController.text}';
                        widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
