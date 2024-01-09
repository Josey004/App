import 'package:app/constants.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/profill/profile.dart';
import 'package:app/widgets/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = CartState.cartItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 238, 209),
        title: Text('Favorite'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Tambahkan Makanan Kesukaan mu'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Harga: ${item['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      removeItem(index);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                });
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.home5,
                    color: Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                });
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.lovely,
                    color: kprimaryColor,
                  ),
                  Text(
                    "Favorite",
                    style: TextStyle(
                      fontSize: 14,
                      color: kprimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                });
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.personalcard5,
                    color: Colors.grey,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Tampilkan dialog atau navigasi ke halaman pilih nomor meja
      //     navigateToTableSelection();
      //   },
      //   child: Icon(Icons.table_chart),
      // ),
    );
  }

  // Fungsi untuk menambahkan item ke keranjang
  void addItem(String name, double price) {
    setState(() {
      cartItems.add({'name': name, 'price': price});
    });
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Fungsi untuk menghitung total harga keranjang
  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }
// Fungsi untuk menghapus item dari keranjang

  // // Fungsi untuk menavigasi ke halaman pilih nomor meja
  // void navigateToTableSelection() async {
  //   final selectedTable = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => NomorMejaPage()),
  //   );
  //   if (selectedTable != null) {
  //     setState(() {
  //       selectedTableNumber = selectedTable;
  //     });
  //   }
  // }

  // // Fungsi untuk menavigasi ke halaman pembayaran
  // void navigateToPaymentScreen(int tableNumber) {
  //   // Implementasi logika untuk membawa nomor meja ke halaman pembayaran
  //   // Misalnya, dengan menggunakan Navigator.push
  //   // dan mengirimkan argumen nomor meja
  // }
}
