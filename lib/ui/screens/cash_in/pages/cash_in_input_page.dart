import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/content_bloc.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CashInInputPage extends StatefulWidget {
  final PageController pageController;

  const CashInInputPage({this.pageController});

  @override
  _CashInInputPageState createState() => _CashInInputPageState();
}

class _CashInInputPageState extends State<CashInInputPage> {
  String sourceAccount = '', sourceAccNum = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Column(
                  children: [
                    ContentBloc(
                      title: 'CASH-IN FROM',
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            child: sourceAccount.isNotEmpty
                                ? ListTile(
                                    title: Text(sourceAccount),
                                    subtitle: Text(
                                      sourceAccNum,
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kPrimaryColor,
                                    ),
                                  )
                                : ListTile(
                                    title: Text('Select a source account'),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                            ),
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Select Source Account',
                                      style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              sourceAccount = 'Pledge Account';
                                              sourceAccNum = '1234-1234-12345678';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text('Pledge Account'),
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('1234-1234-12345678'),
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              sourceAccount = 'iSave Account';
                                              sourceAccNum = '1234-1234-12345678';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text('iSave Account'),
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('1234-1234-87654321'),
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        SafeArea(
                                          child: Container(
                                            color: kPrimaryLightColor,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Link a new account ',
                                                  style: TextStyle(color: kPrimaryColor),
                                                ),
                                                Icon(
                                                  Icons.add_circle,
                                                  size: 18.0,
                                                  color: kPrimaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (sourceAccount.isNotEmpty)
                      Column(
                        children: [
                          Divider(),
                          SizedBox(height: 20.0),
                          MyTextField(
                            title: 'Amount',
                            amountField: true,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (sourceAccount.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(kScreenPadding),
              child: Container(
                height: 50.0,
                child: GradientButton(
                  title: 'Next',
                  onPressed: () {
                    widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
