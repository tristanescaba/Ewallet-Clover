import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetMPINSecurityQuestionsPage extends StatefulWidget {
  final PageController pageController;
  const ResetMPINSecurityQuestionsPage({
    this.pageController,
  });

  @override
  _ResetMPINSecurityQuestionsPageState createState() => _ResetMPINSecurityQuestionsPageState();
}

class _ResetMPINSecurityQuestionsPageState extends State<ResetMPINSecurityQuestionsPage> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _answer1FieldController = TextEditingController();
  final _answer2FieldController = TextEditingController();
  final _answer3FieldController = TextEditingController();
  String _question1, _question2, _question3;
  bool isLoaded = false;

  @override
  void dispose() {
    _answer1FieldController.dispose();
    _answer2FieldController.dispose();
    _answer3FieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<void> getSecurityQuestions() async {
      isLoaded = false;
      ResponseModel response = await _apiService.getSecurityQuestions();
      isLoaded = true;
      if (response.resultCode == 00) {
        setState(() {
          _question1 = '${response.result['data'][0]['question']}';
          _question2 = '${response.result['data'][1]['question']}';
          _question3 = '${response.result['data'][2]['question']}';
        });
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          barrierDismissible: false,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
            button1Function: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        );
      }
    }

    Future<bool> validateAnswers() async {
      ResponseModel response = await _apiService.validateAnswers(
        mobileNumber: user.savedMobileNumber,
        answer1: _answer1FieldController.text,
        answer2: _answer2FieldController.text,
        answer3: _answer3FieldController.text,
      );

      if (response.resultCode == 00) {
        registration.answerToken = response.result['data']['token'];
        return true;
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          barrierDismissible: false,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
          ),
        );
        return false;
      }
    }

    return StateWrapper(
      initState: () async {
        await getSecurityQuestions();
      },
      child: isLoaded
          ? Column(
              children: [
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Text(
                    'Before resetting your MPIN, please answers the following security questions below.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(kScreenPadding),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_question1',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              TextFormField(
                                controller: _answer1FieldController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your answer.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                '$_question2',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              TextFormField(
                                controller: _answer2FieldController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your answer.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                '$_question3',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              TextFormField(
                                controller: _answer3FieldController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your answer.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(kScreenPadding),
                    child: Container(
                      height: 50.0,
                      child: GradientButton(
                        title: 'Validate Answers',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            loadingDialog.show(message: 'Validating answers...');
                            if (await validateAnswers()) {
                              FocusScope.of(context).unfocus();
                              loadingDialog.hide();
                              widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
