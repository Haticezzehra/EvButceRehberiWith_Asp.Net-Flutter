import 'dart:convert';

class FiltreModel {
    String? hareketTuru;
    String? baslangicTarihi;
    String? bitisTarihi;
    int? hesapId;

    FiltreModel({
        this.hareketTuru,
        this.baslangicTarihi,
        this.bitisTarihi,
        this.hesapId,
    });

    FiltreModel copyWith({
        String? hareketTuru,
        String? baslangicTarihi,
        String? bitisTarihi,
        int? hesapId,
    }) => 
        FiltreModel(
            hareketTuru: hareketTuru ?? this.hareketTuru,
            baslangicTarihi: baslangicTarihi ?? this.baslangicTarihi,
            bitisTarihi: bitisTarihi ?? this.bitisTarihi,
            hesapId: hesapId ?? this.hesapId,
        );

    factory FiltreModel.fromRawJson(String str) => FiltreModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toFJson());

    factory FiltreModel.fromJson(Map<String, dynamic> json) => FiltreModel(
        hareketTuru: json["HareketTuru"],
        baslangicTarihi: json["BaslangicTarihi"],
        bitisTarihi: json["BitisTarihi"],
        hesapId: json["HesapId"],
    );

    Map<String, dynamic> toFJson() => {
        "HareketTuru": hareketTuru,
        "BaslangicTarihi": baslangicTarihi,
        "BitisTarihi": bitisTarihi,
        "HesapId": hesapId,
    };
}
