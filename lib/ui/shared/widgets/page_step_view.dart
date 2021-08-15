import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class PageStepView extends StatefulWidget {
  final List<Widget> pages;
  final List<String> pageTitles;
  final PageController pageController;

  const PageStepView({
    this.pages,
    this.pageTitles,
    this.pageController,
  });

  @override
  _PageStepViewState createState() => _PageStepViewState();
}

class _PageStepViewState extends State<PageStepView> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.pages.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 12.0,
                        width: 12.0,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: (index == _currentPage) ? kPrimaryColor : Colors.grey[300],
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                    child: Text(
                      widget.pageTitles[_currentPage],
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: widget.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: widget.pages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ),
      ],
    );
  }
}
