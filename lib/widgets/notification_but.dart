import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/show_provider.dart';

class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowProvider shpro = Provider.of<ShowProvider>(context);
    return Badge(
      position: const BadgePosition(
        top: 8,
        start: 25,
      ),
      badgeColor: Colors.red,
      badgeContent: Text(
        shpro.getNotificationIndex.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none),
        color: Colors.black,
      ),
    );
  }
}
