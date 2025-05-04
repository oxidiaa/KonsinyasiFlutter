import 'package:flutter/material.dart';

class PersonalDetailsView extends StatelessWidget {
  const PersonalDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pribadi'),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Nama: Anita Silvana', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Email: anitasilvana25@gmail.com',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('No. HP: 0812-3456-7890', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Alamat: Jl. Sehat No. 123, Bandung',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
