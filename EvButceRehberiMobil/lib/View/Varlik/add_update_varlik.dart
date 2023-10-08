import 'package:evbutcerehberi/Controller/hesap_controller.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/View/Varlik/varliklar.dart';
import 'package:evbutcerehberi/View/Varlik/varliklarim.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateVarlik extends StatelessWidget {
 AddUpdateVarlik({Key? key, this.varlik}) : super(key: key);
  final HesapModel? varlik;
  final nameController = TextEditingController();
  final aciklamaController = TextEditingController();
  final miktarController = TextEditingController();
  final addOrUpdate = RxBool(false);
 
   
    

  @override
  Widget build(BuildContext context) {
    if (varlik != null) {
      addOrUpdate.value = true;
      nameController.text = varlik!.name ?? "";
      aciklamaController.text = varlik!.description ?? "";
      miktarController.text = (varlik!.miktar ?? 0).toString();
    }
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          addOrUpdate.value ? "Varlık Güncelle" : "Yeni Varlık Ekle",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Adı",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: aciklamaController,
              decoration: const InputDecoration(
                labelText: "Açıklama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: miktarController,
              decoration: const InputDecoration(
                labelText: "Miktar",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                HesapModel kitap = HesapModel(
                  name: nameController.text,
                  description: aciklamaController.text,
                  miktar: int.tryParse(miktarController.text) ?? 0,
                  //Sonra Buraya Kullanıcııd bilgileri gerelecek
                );
                if (addOrUpdate.value) {
                  await Get.put(HesapController())
                      .entityUpdate("Hesap", varlik!.id.toString(), kitap);
                       List<HesapModel> data =
                    await Get.put(HesapController()).getAllEntity("Hesap");
                Get.to(Varliklarim(varlikModel: data));
                } else {
                  await Get.put(HesapController()).postEntity("Hesap", kitap);
                   List<HesapModel> data =
                    await Get.put(HesapController()).getAllEntity("Hesap");
                Get.to(Varliklarim(varlikModel: data));
                }
                List<HesapModel> data = await Get.put(HesapController())
                    .getAllEntity("Varlik");
                Get.to(Varliklar(varlikModel: data));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                addOrUpdate.value ? "Güncelle" : "Kaydet",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
