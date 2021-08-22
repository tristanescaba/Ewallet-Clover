import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/cash_in/cash_in_screen.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/fund_transfer_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;

  void _listenToScrollChange() {
    if (_scrollController.offset >= 80.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

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
                  'Good day, ${user.firstName}!',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.mobile.toString().substring(0, 4)}****${user.mobile.toString().substring(user.mobile.toString().length - 3, user.mobile.toString().length)}',
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
          ),
          endDrawer: Drawer(),
          body: SafeArea(
            bottom: false,
            child: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.4,
              maxHeight: MediaQuery.of(context).size.height,
              parallaxEnabled: true,
              panelBuilder: (controller) => PanelWidget(controller),
              body: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: RefreshIndicator(
                      onRefresh: user.getBalance,
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return BalanceView();
                              },
                              childCount: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(
                        icon: Icons.near_me_outlined,
                        title: 'Transfer',
                        enable: !user.isBalanceLoading,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FundTransferScreen()));
                        },
                      ),
                      ActionButton(
                        icon: Icons.add,
                        title: 'Cash-in',
                        enable: !user.isBalanceLoading,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CashInScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BalanceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
            child: user.isBalanceLoading
                ? Column(
                    children: [
                      CircularProgressIndicator(backgroundColor: Colors.white),
                      SizedBox(height: 10.0),
                      Text(
                        'Updating Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'PHP ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            '${money.format(user.availableBalance)}   ',
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
        ],
      ),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            SvgPicture.asset(
              'assets/svg/undraw_No_data_re_kwbl.svg',
              height: 110.0,
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
