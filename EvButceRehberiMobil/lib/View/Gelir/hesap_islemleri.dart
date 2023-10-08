import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:evbutcerehberi/View/Gelir/add_update_hesapislem.dart';
import 'package:evbutcerehberi/View/Gelir/hesap_islemleri_filtrele.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HesapIslemleri extends StatelessWidget {
  HesapIslemleri({Key? key, required this.gelirModel}) : super(key: key);
  
  final List<HesapHareketleriModel> gelirModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(FiltrelemeSayfasi());
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Hesap Hareketleri",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (gelirModel.isEmpty)
              const Center(
                child: Text(
                  "Bu hesaba ait işlem bulunamadı.",
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              ...gelirModel.map((e) => buildHesapHareketCard(context, e)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddUpdateHesapislem());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  Widget buildHesapHareketCard(BuildContext context, HesapHareketleriModel hareket) {
    final cardColor = hareket.hareketTuru == 'Harcama' ? Colors.red : Colors.green;
    
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cardColor,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hareket.hesapAdi ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  hareket.hareketTuru ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hareket.name ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Miktar: ${hareket.miktar}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[200],
                  ),
                ),
                Text(
                  'İşlem Tarihi: ${hareket.kayitTarihi}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
        
            IconButton(
              onPressed: () async {
                Get.to(AddUpdateHesapislem(
                  gelir: hareket,
                ));
              },
              icon: const Icon(Icons.info_outline),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
