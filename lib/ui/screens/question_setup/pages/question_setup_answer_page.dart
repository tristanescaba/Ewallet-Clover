import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/screens/welcome/welcome_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionSetupAnswerPage extends StatefulWidget {
  final PageController pageController;

  const QuestionSetupAnswerPage({
    this.pageController,
  });

  @override
  _QuestionSetupAnswerPageState createState() => _QuestionSetupAnswerPageState();
}

class _QuestionSetupAnswerPageState extends State<QuestionSetupAnswerPage> {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        );
      }
    }

    Future<bool> saveAnswers() async {
      ResponseModel response = await _apiService.saveAnswers(
        accountID: user.userID == null ? user.savedUserAccountID : user.userID,
        answer1: _answer1FieldController.text,
        answer2: _answer2FieldController.text,
        answer3: _answer3FieldController.text,
      );

      if (response.resultCode == 00) {
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
                    'Please answers the following security questions below. these will be used for your authentication.',
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
                        title: 'Next',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            loadingDialog.show();
                            if (await saveAnswers()) {
                              loadingDialog.hide();
                              if (user.mobileNumber != null) {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen()), (Route<dynamic> route) => false);
                              } else {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (Route<dynamic> route) => false);
                              }
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
