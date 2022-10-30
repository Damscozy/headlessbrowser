// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dashboard_user.dart';
import 'meruwebview.dart';
import 'uberwebview.dart';

class UserNavScreen extends StatefulWidget {
  const UserNavScreen({Key? key}) : super(key: key);

  static const routeName = 'hone-nave-page';

  @override
  State<UserNavScreen> createState() => _UserNavScreenState();
}

class _UserNavScreenState extends State<UserNavScreen> {
  late List<Widget> _screens;
  WebViewController? controller;

  final _scaffoldState = GlobalKey();

  @override
  void initState() {
    _screens = [
      DashBoardUser(),
      UberWebViewPage(),
      MeruWebViewPage(),
    ];

    super.initState();
  }

  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // int _selectedIndex = 0;
  // int? newIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: _selectPage,
        // onTap: (newIndex) async => {
        //   if (newIndex == 1)
        //     {
        //       setState(() {
        //         // controller!.runJavascript(
        //         //     "document.getElementsByTagName('pickup').value='${widget.selectedPickUpAddress}'");
        //         // controller!.runJavascript(
        //         //     "document.getElementsByTagName('drop').value='${widget.selectedDeliveryAddress}'");
        //       })
        //     }
        //   else if (newIndex == 2)
        //     {
        //       setState(() {
        //         // controller!.runJavascript(
        //         //     "document.getElementById('pickup_outstation').value='${widget.selectedPickUpAddress}'");
        //         // controller!.runJavascript(
        //         //     "document.getElementById('drop_outstation').value='${widget.selectedDeliveryAddress}'");
        //       })
        //     }
        // },
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        elevation: 20,
        key: _scaffoldState,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            label: 'Home',
            tooltip: 'Home',
            icon: const Icon(CupertinoIcons.home),
            activeIcon: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Icon(CupertinoIcons.home),
                Icon(CupertinoIcons.home),
              ],
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            label: 'Uber',
            tooltip: 'Uber',
            icon: const Icon(CupertinoIcons.car),
            activeIcon: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Icon(CupertinoIcons.car),
                Icon(CupertinoIcons.car),
              ],
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            label: 'Meru',
            tooltip: 'Meru',
            icon: const Icon(CupertinoIcons.bus),
            activeIcon: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Icon(CupertinoIcons.bus),
                Icon(CupertinoIcons.bus),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
