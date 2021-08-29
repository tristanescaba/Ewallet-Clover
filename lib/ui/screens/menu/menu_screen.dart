import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/shared_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/biometrics/biometrics_screen.dart';
import 'package:ewallet_clover/ui/screens/reset_mpin/reset_mpin_screen.dart';
import 'package:ewallet_clover/ui/screens/user_details/user_details_screen.dart';
import 'package:ewallet_clover/ui/screens/welcome/welcome_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    final user = Provider.of<UserProvider>(context);
    final shared = Provider.of<SharedProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: kLinearGradient,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 50.0),
                width: double.infinity,
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_circle,
                      size: 75.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 18.0),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${user.mobileNumber.toString().substring(0, 4)}****${user.mobileNumber.toString().substring(user.mobileNumber.toString().length - 3, user.mobileNumber.toString().length)}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      ListTile(
                        title: Text('User Details'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen()));
                        },
                      ),
                      Divider(),
                      if (shared.hasBiometrics)
                        SwitchListTile(
                          title: Text('Biometrics'),
                          value: user.hasSavedMPIN,
                          onChanged: (value) {
                            if (value == true) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BiometricsScreen()));
                            } else {
                              showDialog(
                                context: context,
                                child: MyDialog(
                                  title: 'Disable Biometrics',
                                  message: 'Are you sure you want to disable biometrics?',
                                  button1Title: 'Yes',
                                  button2Title: 'No',
                                  button1Function: () async {
                                    await user.deleteMPIN();
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      Divider(),
                      ListTile(
                        title: Text('Change MPIN'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetMPINScreen()));
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Logout'),
                        trailing: Icon(
                          Icons.exit_to_app,
                          color: Colors.redAccent,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            child: MyDialog(
                              title: 'Logout',
                              message: 'Are you sure you want to logout?',
                              button1Title: 'Yes',
                              button2Title: 'No',
                              button1Function: () async {
                                loadingDialog.show(message: 'Logging out...');
                                await user.removeSavedUser();
                                loadingDialog.hide();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (Route<dynamic> route) => false);
                              },
                            ),
                          );
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
