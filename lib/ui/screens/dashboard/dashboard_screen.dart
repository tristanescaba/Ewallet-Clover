import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/cash_in/cash_in_screen.dart';
import 'package:ewallet_clover/ui/screens/dashboard/components/balance_view.dart';
import 'package:ewallet_clover/ui/screens/dashboard/components/history_panel.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/fund_transfer_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/action_button.dart';
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
    final transaction = Provider.of<TransactionProvider>(context);

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
                  '${user.mobileNumber.toString().substring(0, 4)}****${user.mobileNumber.toString().substring(user.mobileNumber.toString().length - 3, user.mobileNumber.toString().length)}',
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
