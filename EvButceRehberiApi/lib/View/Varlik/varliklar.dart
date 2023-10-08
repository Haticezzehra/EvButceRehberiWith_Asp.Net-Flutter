import 'dart:ffi';

import 'package:evbutcerehberi/Controller/hesap_controller.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';

import 'package:evbutcerehberi/View/Varlik/add_update_varlik.dart';
import 'package:evbutcerehberi/View/Varlik/varl%C4%B1k_detay_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Varliklar extends StatelessWidget {
  Varliklar({super.key, this.varlikModel, this.secim});
  final List<HesapModel>? varlikModel;
  final varlikList = <HesapModel>[].obs;
  bool? secim = false;
  @override
  Widget build(BuildContext context) {
    varlikList.value = varlikModel!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar'ın arka plan rengi
        elevation:
            0, // AppBar'ın gölge efekti, 0 yaparak gölgeyi kaldırabilirsiniz
        centerTitle: true, // Başlığın ortalanmasını sağlar
        title: const Text(
          "VARLIKLAR",
          style: TextStyle(
            fontSize: 24, // Başlık metni boyutunu ayarlayabilirsiniz
            fontWeight: FontWeight.bold, // Kalın bir yazı stili
            color: Colors.white, // Metin rengi
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            if (varlikList.isEmpty)
              const Center(
                child: Text(
                  "Varlık bulunamadı.",
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              // SearchBar(

              //   leading: const Icon(Icons.search),
              // ),
              ...varlikList.asMap().entries.map((e) => GestureDetector(
                    onTap: () async {
                      if (secim!) {
                        var hesapModel =
                            HesapModel(name: e.value.name, id: e.value.id);
                            Get.back(result: hesapModel);
                      }
                      
                    },
                    child: Card(
                        child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white, // Arka plan rengi
                        borderRadius:
                            BorderRadius.circular(10), // Köşeleri yuvarlat
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Gölge rengi
                            spreadRadius: 2, // Gölge yayılımı
                            blurRadius: 5, // Gölge bulanıklığı
                            offset: const Offset(0, 3), // Gölge konumu
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.value.name ?? "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Miktar: ${e.value.miktar}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                             IconButton(
                            onPressed: () async {
                              var data = await Get.put(HesapController())
                                  .getEntity("Hesap/${e.value.id}");
                              Get.to(VarlikDetay(varlik: data));
                            },
                            icon: const Icon(Icons.info_outline),
                            color: Colors.blue, // İcon rengi
                          ),
                           IconButton(
                            onPressed: () async {
                              var data = await Get.put(HesapController())
                                  .getEntity("Hesap/${e.value.id}");
                              Get.to(AddUpdateVarlik(varlik: data));
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.blue, // İcon rengi
                          ),
                          ],)
                         
                        ],
                      ),
                    )),
                  ))
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddUpdateVarlik());
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add), // FAB rengini mavi olarak ayarlar
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.blue, // BottomNavigationBar rengini mavi olarak ayarlar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Buraya gerekli bottom navigation butonlarını ekleyebilirsiniz
          ],
        ),
      ),
    );
  }
}
