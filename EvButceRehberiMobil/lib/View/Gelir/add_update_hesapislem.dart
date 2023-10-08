import 'package:evbutcerehberi/Controller/hesap_controller.dart';
import 'package:evbutcerehberi/Controller/hesap_hareketleri_controller.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:evbutcerehberi/View/Gelir/hesap_islemleri.dart';
import 'package:evbutcerehberi/View/Varlik/varliklar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateHesapislem extends StatelessWidget {
  AddUpdateHesapislem({super.key, this.gelir});
  final addOrUpdate = RxBool(false);
  final HesapHareketleriModel? gelir;
  final name = TextEditingController(text: "").obs;
  final description = TextEditingController(text: "").obs;
  final miktar = TextEditingController(text: "").obs;
  final hesapAdi = TextEditingController(text: "").obs;
   final hesapId = TextEditingController(text: "").obs;
  final varlikTuruAdi = TextEditingController(text: "").obs;
  final selectedOption = "Harcama".obs;

  @override
  Widget build(BuildContext context) {
    if (gelir != null) {
      addOrUpdate.value = true;
      name.value.text = gelir?.name ?? "";
      description.value.text = gelir?.description ?? "";
      varlikTuruAdi.value.text = gelir?.hesapAdi ?? "";
      miktar.value.text =
          (int.tryParse(gelir?.miktar?.toString() ?? "0") ?? 0).toString();
      hesapAdi.value.text = gelir?.hesapAdi ?? "";
      hesapId.value.text=gelir?.hesapId.toString() ?? "";
    selectedOption.value=gelir?.hareketTuru ?? "Harcama";
      
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          addOrUpdate.value ? "İşlem Güncelle" : "İşlem Ekle",
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
              controller: name.value,
              decoration: const InputDecoration(
                labelText: "İşlem",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: description.value,
              decoration: const InputDecoration(
                labelText: "Açıklama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: hesapAdi.value,
              decoration: InputDecoration(
                labelText: "Hesap",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () async {
                    List<HesapModel> data =
                        await Get.put(HesapController()).getAllEntity("Hesap");
                    var args =await Get.to(Varliklar(
                      varlikModel: data,
                      secim: true,
                    ));

                    if (args != null && args is HesapModel) {
                      HesapModel hesapModel = args;
                      hesapAdi.value.text=hesapModel.name!;
                      hesapId.value.text=hesapModel.id.toString();
                      
                    }
                   
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => DropdownButton<String>(
                  value: selectedOption.value,
                  onChanged: (String? newValue) {
                    selectedOption.value = newValue!;
                  },
                  items: <String>["Kazanc", "Harcama"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            TextFormField(
              controller: miktar.value,
              decoration: const InputDecoration(
                labelText: "Miktar",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                HesapHareketleriModel hesapIslem=HesapHareketleriModel(
                  name: name.value.text,
                  description: description.value.text,
                  hareketTuru: selectedOption.value,
                  hesapAdi: hesapAdi.value.text,
                  hesapId: int.tryParse(hesapId.value.text) ?? 0,
                  miktar: int.tryParse(miktar.value.text)

                );
                if(addOrUpdate.value)
                {
 await Get.put(HesapHareketleriController()).entityUpdate("HesapHareketleri",gelir!.id.toString() ,hesapIslem);
                }
                else{
                   await Get.put(HesapHareketleriController()).postEntity("HesapHareketleri", hesapIslem);
                }
                List<HesapHareketleriModel> data =
                    await Get.put(HesapHareketleriController()).getAllEntity("HesapHareketleri");
                Get.to(HesapIslemleri(
                  gelirModel: data,
                ));
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
