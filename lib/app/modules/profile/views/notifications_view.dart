import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Notifikasi Email'),
            subtitle: const Text('Terima notifikasi melalui email.'),
            value: true,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Notifikasi Push'),
            subtitle: const Text('Terima notifikasi push di perangkat Anda.'),
            value: true,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Notifikasi SMS'),
            subtitle: const Text('Terima notifikasi melalui SMS.'),
            value: false,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
