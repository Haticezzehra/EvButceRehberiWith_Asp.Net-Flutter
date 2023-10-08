import 'dart:math';

import 'package:evbutcerehberi/Controller/hesap_hareketleri_controller.dart';
import 'package:evbutcerehberi/Controller/kullanici_controller.dart';
import 'package:evbutcerehberi/Controller/hesap_controller.dart';

import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/View/Gelir/hesap_islemleri.dart';
import 'package:evbutcerehberi/View/Rapor/rapor_filtre.dart';

import 'package:evbutcerehberi/View/Varlik/varliklar.dart';
import 'package:evbutcerehberi/View/login_page.dart';
import 'package:evbutcerehberi/View/profil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Varliklarim extends StatelessWidget {
  Varliklarim({super.key, required this.varlikModel, this.id});
  final List<HesapModel> varlikModel;
  int? id;

  @override
  Widget build(BuildContext context) {
    double toplamMiktar =
        varlikModel.fold(0, (sum, varlik) => sum + (varlik.miktar ?? 0));

    final random = Random();
    List<Color> renkler = List.generate(varlikModel.length, (index) {
      return Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar'ın arka plan rengi
        elevation:
            0, // AppBar'ın gölge efekti, 0 yaparak gölgeyi kaldırabilirsiniz
        centerTitle: true, // Başlığın ortalanmasını sağlar
        title: const Text(
          "VARLIKLARIM",
          style: TextStyle(
            fontSize: 24, // Başlık metni boyutunu ayarlayabilirsiniz
            // fontWeight: FontWeight.bold, // Kalın bir yazı stili
            color: Colors.white, // Metin rengi
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wallet_sharp,
                      size: 60,
                      color: Colors.white, // Icon rengini beyaz olarak ayarlar
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ev Bütçe Rehberi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Hesaplar'),
              leading: const Icon(Icons.account_balance_wallet,
                  color: Colors.blue), // Icon rengini mavi olarak ayarlar
              onTap: () async {
                List<HesapModel> data =
                    await Get.put(HesapController()).getAllEntity("Hesap");
                Get.to(Varliklar(
                  varlikModel: data,
                ));
              },
            ),
            ListTile(
              title: const Text('Hesap İşlemleri'),
              leading: const Icon(Icons.attach_money,
                  color: Colors.blue), // Icon rengini mavi olarak ayarlar
              onTap: () async {
                List<HesapHareketleriModel> data =
                    await Get.put(HesapHareketleriController()).getAllEntity("HesapHareketleri");
                Get.to(HesapIslemleri(
                  gelirModel: data,
                ));
              },
            ),
            ListTile(
              title: const Text('Rapor Olustur'),
              leading: const Icon(Icons.description,
                  color: Colors.blue), // Icon rengini mavi olarak ayarlar
              onTap: () {
                Get.to(RaporOlustur());
              },
            ),
            ListTile(
              title: const Text('Profil'),
              leading: const Icon(Icons.person,
                  color: Colors.blue), // Icon rengini mavi olarak ayarlar
              onTap: () async {
                var kullanici = await Get.put(KullaniciController())
                    .getEntity("Kullanici/$id");

                Get.to(Profil(kullanici: kullanici));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Çıkış Yap'),
              leading: const Icon(Icons.exit_to_app,
                  color: Colors.blue), // Icon rengini mavi olarak ayarlar
              onTap: () {
                Get.to(LoginPage());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 300,
                  
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: varlikModel.isNotEmpty
                    ?List.generate(varlikModel.length, (index) {
                        final varlik = varlikModel[index];
                        final yuzde = (varlik.miktar! / toplamMiktar) * 100;
                        return PieChartSectionData(
                          value: yuzde,
                          color: renkler[index],
                          title: ' ${yuzde.toStringAsFixed(2)}%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }) : [
                       
                        PieChartSectionData(
                          value: 100,
                          color: Colors.grey,
                        
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DataTable(
                columnSpacing: 16,
                // ignore: deprecated_member_use
                dataRowHeight: 48,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Varlık',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Miktar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(label: Text('')),
                ],
                rows: varlikModel.asMap().entries.map((entry) {
                  final index = entry.key;
                  final varlik = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(varlik.name ?? ""),
                      ),
                      DataCell(
                        Text(varlik.miktar.toString()),
                      ),
                      DataCell(
                        Container(
                          width: 12,
                          height: 12,
                          color: renkler[index],
                        ),
                      ),
                    ]
                  );
                }).toList(),
              ),
            ] 
                      
          ),
        ),
      ),
    );
  }
}
