import 'package:evbutcerehberi/Model/kullanici_model.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget{
   const Profil( {super.key,this.kullanici});
    final ModelKullanici? kullanici;


  @override
  Widget build(BuildContext context) {
 return Scaffold(
  appBar: AppBar(title:const Text("Profil")),
  body: Column(children: [
    Text(kullanici?.kullaniciAdSoyad ??" ")
  ]),
 );
  }

}