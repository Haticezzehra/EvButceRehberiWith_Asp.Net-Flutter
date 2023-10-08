import 'package:evbutcerehberi/Controller/hesap_hareketleri_controller.dart';
import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/View/Gelir/hesap_islemleri.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VarlikDetay extends StatelessWidget {
  final HesapModel? varlik;

  const VarlikDetay({Key? key, this.varlik}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Varlık Detay", style: TextStyle(
            fontSize: 24, // Başlık metni boyutunu ayarlayabilirsiniz
            // fontWeight: FontWeight.bold, // Kalın bir yazı stili
            color: Colors.white, // Metin rengi
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.blue, // AppBar rengini mavi olarak ayarlar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              varlik!.name.toString(),
              style: const TextStyle(
                fontSize: 24, // Başlık metni boyutunu ayarlar
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Boşluk ekler
            Text(
              "Açıklama: ${varlik!.description.toString()}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Miktar: ${varlik!.miktar.toString()}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () async{
               List<HesapHareketleriModel> data =
                    await Get.put(HesapHareketleriController()).getAllEntity("HesapHareketleri");
                    List<HesapHareketleriModel> filtrelenmisData = data
    .where((hareket) => hareket.hesapId == varlik!.id)
    .toList();
                Get.to(HesapIslemleri(
                  gelirModel: filtrelenmisData,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Düğme rengini mavi olarak ayarlar
              ),
              child: const Text("Hesap Hareketleri"),
            )
          ],
        ),
      ),
    );
  }
}
