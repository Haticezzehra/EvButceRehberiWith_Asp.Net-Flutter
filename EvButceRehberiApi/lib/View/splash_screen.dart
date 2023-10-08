
import 'package:evbutcerehberi/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(), // Ana uygulama splash ekrana başlasın
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 saniye sonra ana ekrana geçiş yap
    Future.delayed(const Duration(seconds: 2), () async{
     
                    
         Get.to( LoginPage());
       
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue, // Splash ekranın arka plan rengi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ev Bütçe Rehberi',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white, // Metin rengi
              ),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(
              color: Colors.white, // Yüklenme göstergesi rengi
            ),
          ],
        ),
      ),
    );
  }
}
