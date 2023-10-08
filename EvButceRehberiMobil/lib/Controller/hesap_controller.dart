import 'package:evbutcerehberi/Controller/ortak_controller.dart';
import 'package:evbutcerehberi/Model/filtre_model.dart';
import 'package:evbutcerehberi/Model/hesap_model.dart';
import 'package:get/get.dart';


class HesapController extends GetxController
    with EntityMixin<HesapModel> {
  @override
HesapModel fromJson(json) {
    return HesapModel.fromJson(json);
  }

  @override
  toJson(HesapModel entity) {
    return entity.toJson();
  }

  @override
  toFJson(FiltreModel entity) {
    FiltreModel entity;
  }
}