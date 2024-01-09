import 'package:flutter/material.dart';

class HalamanPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Anda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Tambahkan widget atau konten sesuai dengan kebutuhan Anda
            // Contoh:
            ListTile(
              title: Text('Item 1'),
              subtitle: Text('Deskripsi item 1'),
              trailing: Text('\$10.00'),
            ),
            ListTile(
              title: Text('Item 2'),
              subtitle: Text('Deskripsi item 2'),
              trailing: Text('\$15.00'),
            ),
            // ... Tambahkan item pesanan lainnya sesuai kebutuhan

            SizedBox(height: 20),
            Text(
              'Total: \$25.00', // Gantilah dengan total harga pesanan Anda
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lakukan aksi saat tombol "Checkout" diklik
                print('Checkout Pesanan');
                // Tambahkan logika checkout atau navigasi ke halaman pembayaran
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
