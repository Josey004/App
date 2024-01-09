import 'package:flutter/material.dart';

class NomorMejaPage extends StatefulWidget {
  const NomorMejaPage({Key? key}) : super(key: key);

  @override
  _NomorMejaPageState createState() => _NomorMejaPageState();
}

class _NomorMejaPageState extends State<NomorMejaPage> {
  int selectedTable = 1; // Default value agar tidak null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Nomor Meja'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedTable,
              onChanged: (value) {
                setState(() {
                  selectedTable = value!;
                });
              },
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Meja $value'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman sebelumnya dengan mengembalikan nilai nomor meja
                Navigator.pop(context, selectedTable);
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
