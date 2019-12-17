import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    this.title,
    this.index,
    this.child,
    this.selected,
    this.icon,
    this.onPressed,
  });
  final String title;
  final Widget child;
  final int index;
  final bool selected;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: selected == true ? 2.0 : 0.0,
      shape: CircleBorder(
        side: selected == true
            ? BorderSide(
                color: Theme.of(context).primaryColorLight,
                width: 1.0,
              )
            : BorderSide.none,
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          backgroundColor: selected == true
              ? Theme.of(context).cardColor
              : Colors.transparent,
          child: child ??
              IconButton(
                icon: Icon(
                  icon,
                  color: selected
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: onPressed,
              ),
        ),
      ),
    );
  }
}
