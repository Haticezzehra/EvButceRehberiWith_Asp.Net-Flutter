import 'package:evbutcerehberi/Controller/ortak_controller.dart';
import 'package:evbutcerehberi/Model/filtre_model.dart';
import 'package:evbutcerehberi/Model/kullanici_model.dart';
import 'package:get/get.dart';


class KullaniciController extends GetxController
    with EntityMixin<ModelKullanici> {
  @override
  ModelKullanici fromJson(json) {
    return ModelKullanici.fromJson(json);
  }

  @override
  toJson(ModelKullanici entity) {
    return entity.toJson();
  }

  @override
  toFJson(FiltreModel entity) {
   FiltreModel entity;
  }
}

