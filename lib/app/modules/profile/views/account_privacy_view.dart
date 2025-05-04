import 'package:flutter/material.dart';

class AccountPrivacyView extends StatelessWidget {
  const AccountPrivacyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privasi Akun'),
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
            title: const Text('Akun Privat'),
            subtitle: const Text(
                'Hanya pengguna yang diizinkan yang dapat melihat profil Anda.'),
            value: true,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Tampilkan Email'),
            subtitle: const Text('Izinkan orang lain melihat email Anda.'),
            value: false,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Tampilkan Nomor HP'),
            subtitle: const Text('Izinkan orang lain melihat nomor HP Anda.'),
            value: false,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
