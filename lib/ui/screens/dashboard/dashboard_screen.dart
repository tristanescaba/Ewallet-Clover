import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good day, Juan!',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0912****789',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: PreferredSize(
              child: SizedBox(height: 10.0),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.4,
              maxHeight: MediaQuery.of(context).size.height,
              parallaxEnabled: true,
//              borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
              panelBuilder: (controller) => PanelWidget(controller),
              body: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PHP ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                '5,000.78',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActionButton(
                          icon: Icons.near_me_outlined,
                          title: 'Transfer',
                          onPressed: () {},
                        ),
                        ActionButton(
                          icon: Icons.add,
                          title: 'Deposit',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
          child: Center(
            child: Container(
              height: 6.0,
              width: 45.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SvgPicture.asset(
              'assets/svg/undraw_No_data_re_kwbl.svg',
              height: 180.0,
            ),
            SizedBox(height: 30.0),
            Text(
              'You don\'t have any transactions yet',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ],
    );
  }
}
