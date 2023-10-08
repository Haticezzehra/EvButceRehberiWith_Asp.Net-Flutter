import 'package:evbutcerehberi/Controller/ortak_controller.dart';
import 'package:evbutcerehberi/Model/filtre_model.dart';

import 'package:evbutcerehberi/Model/hesap_hareketleri_model.dart';
import 'package:get/get.dart';


class HesapHareketleriController extends GetxController
    with EntityMixin<HesapHareketleriModel> {
  @override
  HesapHareketleriModel fromJson(json) {
    return HesapHareketleriModel.fromJson(json);
  }

  @override
  toJson(HesapHareketleriModel entity) {
    return entity.toJson();
  }

  @override
  toFJson(FiltreModel entity) {
 entity.toFJson();
  }
}

