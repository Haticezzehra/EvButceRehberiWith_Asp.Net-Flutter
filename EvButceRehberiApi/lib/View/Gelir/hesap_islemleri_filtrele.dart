import 'package:evbutcerehberi/Controller/hesap_controller.dart';
import 'package:evbutcerehberi/Controller/hesap_hareketleri_controller.dart';
import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:evbutcerehberi/View/Gelir/hesap_islemleri.dart';
import 'package:evbutcerehberi/View/Varlik/varliklar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FiltrelemeSayfasi extends StatelessWidget {
  FiltrelemeSayfasi({super.key});

  final _baslangicTarihi = "".obs;
  var secilenaBaslangicTarihi = "".obs;
  final _bitisTarihi = "".obs;
  var secilenaBitisTarihi = "".obs;
  final _secilenIslemTuru = "Kazanc".obs;
  final _secilenHesap = "Hesap 1".obs;
  final secilenIslem = "".obs;
  final hesapAdi = TextEditingController(text: "").obs;
  final hesapId = TextEditingController(text: "").obs;
  final List<String> _islemTurleri = ['Kazanc', 'Harcama'];
  final List<String> _hesaplar = ['Hesap 1', 'Hesap 2', 'Hesap 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filtreleme Sayfası',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarih Aralığı Seçin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  _baslangicTarihi.value =
                                      picked.toLocal().toString();
                                }
                              },
                              child: Obx(() =>  Text(
                                _baslangicTarihi.value == null
                                    ? 'Başlangıç Tarihi Seç'
                                    : 'Başlangıç Tarihi: ${_baslangicTarihi.value.toString().split(' ')[0]}',
                              ),),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  _bitisTarihi.value =
                                      picked.toLocal().toString();
                                }
                              },
                              child: Obx(() =>  Text(
                                _bitisTarihi.value == null
                                    ? 'Bitiş Tarihi Seç'
                                    : 'Bitiş Tarihi: ${_bitisTarihi.value.toString().split(' ')[0]}',
                              ),)
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'İşlem Türünü Seçin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _secilenIslemTuru.value,
                        onChanged: (String? newValue) {
                          _secilenIslemTuru.value = newValue!;
                          secilenIslem.value = _secilenIslemTuru.value;
                        },
                        items: _islemTurleri.map((String islemTuru) {
                          return DropdownMenuItem<String>(
                            value: islemTuru,
                            child: Text(islemTuru),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hesap Seçin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: hesapAdi.value,
                        decoration: InputDecoration(
                          labelText: "Hesap",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              List<HesapModel> data = await Get.put(HesapController())
                                  .getAllEntity("Hesap");
                              var args = await Get.to(Varliklar(
                                varlikModel: data,
                                secim: true,
                              ));

                              if (args != null && args is HesapModel) {
                                HesapModel hesapModel = args;
                                hesapAdi.value.text = hesapModel.name!;
                                hesapId.value.text = hesapModel.id.toString();
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  HesapHareketleriModel filtreModel = HesapHareketleriModel(
                    
                      hareketTuru: secilenIslem.value,
                      baslangicTarihi: _baslangicTarihi.value.toString().split(' ')[0].toString() ?? "",
                      bitisTarihi: _bitisTarihi.value.toString().split(' ')[0]?.toString() ?? "",
                      hesapId:  hesapId.value.text !="" ? int.parse(hesapId.value.text) : 0);
                  List<HesapHareketleriModel> data =
                      await Get.put(HesapHareketleriController())
                          .postFiltreli("Filtreli", filtreModel);
                  Get.to(HesapIslemleri(
                    gelirModel: data,
                  ));
                },
                child: Text('Filtrele'),
              ),
              ElevatedButton(
                onPressed: () async {
                  HesapHareketleriModel filtreModel = HesapHareketleriModel(
                    
                      hareketTuru: secilenIslem.value,
                      baslangicTarihi: _baslangicTarihi.value.toString().split(' ')[0].toString() ?? "",
                      bitisTarihi: _bitisTarihi.value.toString().split(' ')[0]?.toString() ?? "",
                      hesapId:  hesapId.value.text !="" ? int.parse(hesapId.value.text) : 0);
                  List<HesapHareketleriModel> data =
                      await Get.put(HesapHareketleriController())
                          .postFiltreli("Filtreli", filtreModel);
                  Get.to(HesapIslemleri(
                    gelirModel: data,
                  ));
                },
                child: Text('Rapor Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
