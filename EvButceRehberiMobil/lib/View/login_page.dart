import 'package:evbutcerehberi/Controller/ortak_controller.dart';
import 'package:evbutcerehberi/Controller/hesap_controller.dart';
import 'package:evbutcerehberi/Model/token_model.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/View/Varlik/varliklarim.dart';
import 'package:evbutcerehberi/View/kayitol_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final kullaniciAdi = TextEditingController();
  final parola = TextEditingController();
  final rememberMe = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const SizedBox(height: 20),
            const Text(
              "Ev Bütçe Rehberi",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: rememberMe,
                  builder: (context, value, child) {
                    return Checkbox(
                      activeColor: Colors.blue,
                      value: rememberMe.value,
                      onChanged: (newValue) {
                        rememberMe.value = newValue ?? false;
                      },
                    );
                  },
                ),
                const Text('Beni Hatırla'),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                TokenModel token = await ClientHelper.getToken(
                  kullaniciAdi.value.text,
                  parola.value.text,
                );
                ClientHelper.setToken(token);

                List<HesapModel> data =
                    await Get.put(HesapController()).getAllEntity("Hesap");
                Get.to(Varliklarim(varlikModel: data));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text("Giriş Yap"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Get.to(KayitOl());
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
