import 'package:flutter/material.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/main_drawer.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notificationsText),
      ),
      drawer: new MainDrawerView(),
      body: ListView(
        children: <Widget>[Text(notificationsText)],
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.clear_all),
          onPressed: () => clearNotifications()),
    );
  }

  clearNotifications() {
    //todo handle clear notificaions
  }
}
