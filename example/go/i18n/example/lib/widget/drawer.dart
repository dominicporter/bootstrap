import 'package:flutter/material.dart';

import './drawer_list_tile.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({@required this.index});
  //final void Function(int index) onItemTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _topList = <Widget>[
      DrawerListTile(
        icon: Icons.home,
        selected: index == 0,
        index: 0,
        onPressed: () {
          // Navigator.of(context).pushNamed('/news');
        },
      ),
      DrawerListTile(
        icon: Icons.chat_bubble,
        selected: index == 1,
        index: 1,
        onPressed: () {
          //Navigator.of(context).pushNamed('/chatgroup');
        },
      ),
      DrawerListTile(
        icon: Icons.settings_input_antenna,
        selected: index == 2,
        index: 2,
        onPressed: () {
          // Navigator.of(context).pushNamed('/enrollments');
        },
      ),
    ];

    final List<Widget> _bottomList = <Widget>[
      //AvatarLoader(future: _user.globalUser), // index 3
      DrawerListTile(
        icon: Icons.settings,
        selected: index == 4,
        index: 4,
        onPressed: () {
          // Navigator.of(context).pushNamed('/settings');
        },
      ),
      DrawerListTile(
        icon: Icons.exit_to_app,
        selected: index == 5,
        index: 5,
        onPressed: () {
          // _user.userLoggedIn = false;
          // Navigator.of(context).pushNamed('/signout');
        },
      ),
    ];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  for (Widget child in _topList)
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        child,
                        const SizedBox(height: 8),
                      ],
                    )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  for (Widget child in _bottomList)
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        child,
                        const SizedBox(height: 8),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
