
import 'package:evbutcerehberi/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KayitOl extends StatelessWidget {
  KayitOl({super.key});

  final kullaniciAdi = TextEditingController();
  final parola = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Yeni Hesap Oluştur",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: kullaniciAdi,
              decoration: const InputDecoration(
                labelText: "Kullanıcı Adı",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: parola,
              decoration: const InputDecoration(
                labelText: "Parola",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
             OutlinedButton(
              onPressed: () {
                Get.to(LoginPage());
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue, backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}
