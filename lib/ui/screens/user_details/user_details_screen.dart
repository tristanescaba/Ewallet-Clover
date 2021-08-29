import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InformationTile(
                title: 'User ID',
                value: '${user.userID}',
              ),
              InformationTile(
                title: 'First Name',
                value: '${user.firstName}',
              ),
              if (user.middleName != 'NA')
                InformationTile(
                  title: 'Middle Name',
                  value: '${user.middleName}',
                ),
              InformationTile(
                title: 'Last Name',
                value: '${user.lastName}',
              ),
              InformationTile(
                title: 'Mobile Number',
                value: '${user.mobileNumber}',
              ),
              InformationTile(
                title: 'E-mail',
                value: '${user.email}',
              ),
              InformationTile(
                title: 'Birth Date',
                value: '${user.dateOfBirth}',
              ),
              InformationTile(
                title: 'Gender',
                value: '${user.gender}',
              ),
              InformationTile(
                title: 'Marital Status',
                value: '${user.maritalStatus}',
              ),
              InformationTile(
                title: 'Physical Address',
                value: '${user.address}',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
