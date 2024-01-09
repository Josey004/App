import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_2/auth/auth_service.dart';
// import 'package:flutter_application_2/pages/home_page.dart';
// import 'package:flutter_application_2/pages/register_page.dart';
import 'package:app/auth/auth_service.dart';
import 'package:app/screens/adminn/home_admin.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/intro_login_register/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 238, 209),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: GoogleFonts.dmSans(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log Into Your Account',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 40,
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 12), // Adjusted the text size
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 40,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: 12), // Adjusted the text size
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () async {
                  print('Entered Email before trim: ${_emailController.text}');
                  print(
                      'Entered Password before trim: ${_passwordController.text}');
                  try {
                    UserCredential userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    print('Entered Email: ${_emailController.text.trim()}');

                    if (userCredential.user != null) {
                      // Periksa apakah email pengguna yang masuk cocok dengan email admin
                      if (userCredential.user!.email == 'admin@admin.com') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        print('Akses ditolak. Pengguna bukan admin.');
                        // Tampilkan pesan kesalahan atau lakukan tindakan lain untuk pengguna bukan admin
                      }
                    }
                  } on FirebaseAuthException catch (e) {
                    print('Kesalahan Otentikasi Firebase: ${e.message}');
                    // Handle kesalahan otentikasi lainnya di sini
                    print('Entered Email: ${_emailController.text.trim()}');
                    print(
                        'Entered Password: ${_passwordController.text.trim()}');
                  }
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  backgroundColor: Color(0xFFFF9F5A),
                  foregroundColor: Colors.white,
                  minimumSize: Size(320, 50),
                  shape: RoundedRectangleBorder(
                    // Mengatur bentuk menjadi bulat
                    borderRadius: BorderRadius.circular(
                        27), // Anda dapat menyesuaikan nilai untuk membuatnya lebih bulat atau kurang bulat
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
