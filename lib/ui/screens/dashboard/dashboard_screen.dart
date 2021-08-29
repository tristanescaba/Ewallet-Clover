import 'package:ewallet_clover/core/providers/shared_provider.dart';
import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/dashboard/components/balance_view.dart';
import 'package:ewallet_clover/ui/screens/dashboard/components/history_panel.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/fund_transfer_screen.dart';
import 'package:ewallet_clover/ui/screens/menu/menu_screen.dart';
import 'package:ewallet_clover/ui/screens/my_qr/my_qr_screen.dart';
import 'package:ewallet_clover/ui/screens/welcome/welcome_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/action_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final shared = Provider.of<SharedProvider>(context);
    final transaction = Provider.of<TransactionProvider>(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
        WillPopScope(
          onWillPop: () async => showDialog(
            context: context,
            child: MyDialog(
              message: 'Are you sure you want to go back to login screen?',
              button1Title: 'Yes',
              button2Title: 'No',
              button1Function: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (Route<dynamic> route) => false);
              },
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        '${shared.greet}, ${user.firstName}!',
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${user.mobileNumber.toString().substring(0, 4)}****${user.mobileNumber.toString().substring(user.mobileNumber.toString().length - 3, user.mobileNumber.toString().length)}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.person_circle,
                      size: 35.0,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
                    },
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
            body: SafeArea(
              bottom: false,
              child: SlidingUpPanel(
                minHeight: MediaQuery.of(context).size.height * 0.4,
                maxHeight: MediaQuery.of(context).size.height,
                parallaxEnabled: true,
                panelBuilder: (controller) => HistoryPanel(controller),
                body: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          user.getBalance();
                        },
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
                            transaction.resetValues();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FundTransferScreen()));
                          },
                        ),
                        ActionButton(
                          icon: Icons.qr_code_rounded,
                          title: 'My QR',
                          enable: !user.isBalanceLoading,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyQRScreen()));
                          },
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
