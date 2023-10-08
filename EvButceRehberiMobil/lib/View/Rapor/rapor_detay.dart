import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rapor extends StatelessWidget {
  Rapor({super.key, this.gelirModel});
  final List<HesapHareketleriModel>? gelirModel;

  @override
  Widget build(BuildContext context) {
    double toplamKazanc = 0;
    double toplamHarcama = 0;
    bool kazanma = false;
    bool harcama = false;

    // Gelir modelini gezerek kazançları ve harcamaları hesapla
    if (gelirModel != null) {
      for (var hareket in gelirModel!) {
        if (hareket.hareketTuru == 'Kazanc') {
          kazanma = true;
          toplamKazanc += hareket.miktar ?? 0;
        } else if (hareket.hareketTuru == 'Harcama') {
          harcama = true;
          toplamHarcama += hareket.miktar ?? 0;
        }
      }
    }

    String harcamaDurumu = toplamKazanc >= toplamHarcama
        ? "Kazançlar Harcamaları Karşılıyor + ${toplamKazanc-toplamHarcama}"
        : "Kazançlar Harcamaları Karşılamıyor \n- ${toplamHarcama-toplamKazanc}";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rapor",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (kazanma)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Kazanç',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$toplamKazanc',
                        style: TextStyle(fontSize: 24, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            if (harcama)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Harcama',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$toplamHarcama',
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            if (kazanma && harcama)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Harcama Durumu',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        harcamaDurumu,
                        style: TextStyle(
                          fontSize: 24,
                          color: toplamKazanc >= toplamHarcama
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
