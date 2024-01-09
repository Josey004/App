// import 'package:flutter_application_2/pages/home_page.dart';
// import 'package:flutter_application_2/pages/login_page.dart';
// import 'package:flutter_application_2/pages/register_page.dart';
// import 'package:flutter_application_2/auth/auth_service.dart';
import 'package:app/auth/auth_service.dart';
import 'package:app/screens/intro_login_register/login_admin.dart';
import 'package:app/screens/intro_login_register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 238, 209),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Color.fromARGB(255, 192, 188, 148), // Set your desired background color
                  //   borderRadius: BorderRadius.circular(300.0),
                  // Optional: Add border radius
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'WELCOME',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Login To Find Your Fav Foods',
                style: GoogleFonts.dmSerifText(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  // Tampilkan dialog saat tombol ditekan
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text('Login As',
                            //     style: GoogleFonts.poppins(
                            //         fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            // Kolom untuk menempatkan TextButton di tengah
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Tombol pertama
                                TextButton(
                                  child: Text(
                                    'Guest',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  onPressed: () {
                                    // Lakukan aksi ketika opsi 1 ditekan

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                                ),
                                // Spasi antara tombol
                                SizedBox(height: 10),
                                // Tombol kedua
                                TextButton(
                                  child: Text('Admin',
                                      style: GoogleFonts.poppins()),
                                  onPressed: () {
                                    // Lakukan aksi ketika opsi 2 ditekan
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginAdmin()),
                                    ); // Tutup dialog
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Get Started',
                    style: GoogleFonts.poppins(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  backgroundColor: Color(0xFFFF9F5A),
                  foregroundColor: Colors.white,
                  minimumSize: Size(320, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => LoginScreen(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width / 2,
              //     decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 0, 0, 0),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     padding: const EdgeInsets.all(15),
              //     child: Center(
              //       child: Text(
              //         'Get Started',
              //         style: GoogleFonts.dmSerifDisplay(
              //           color: Colors.white,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 12),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => RegisterScreen(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width / 2,
              //     decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 0, 0, 0),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     padding: const EdgeInsets.all(12),
              //     child: const Center(
              //       child: Text(
              //         'Register',
              //         style: TextStyle(
              //           color: Color.fromARGB(255, 255, 255, 255),
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
