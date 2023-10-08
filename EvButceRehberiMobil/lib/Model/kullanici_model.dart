

import 'dart:convert';

List<ModelKullanici> modelKullaniciFromJson(String str) => List<ModelKullanici>.from(json.decode(str).map((x) => ModelKullanici.fromJson(x)));

String modelKullaniciToJson(List<ModelKullanici> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelKullanici {
    int? id;
    String? kullaniciAdSoyad;
    String? parola;
    dynamic kayitTarihi;
    dynamic kayitYapan;

    ModelKullanici({
         this.id,
         this.kullaniciAdSoyad,
         this.parola,
        this.kayitTarihi,
         this.kayitYapan,
    });

    ModelKullanici copyWith({
        int? id,
        String? kullaniciAdSoyad,
        String? parola,
        dynamic kayitTarihi,
        dynamic kayitYapan,
    }) => 
        ModelKullanici(
            id: id ?? this.id,
            kullaniciAdSoyad: kullaniciAdSoyad ?? this.kullaniciAdSoyad,
            parola: parola ?? this.parola,
            kayitTarihi: kayitTarihi ?? this.kayitTarihi,
            kayitYapan: kayitYapan ?? this.kayitYapan,
        );

    factory ModelKullanici.fromJson(Map<String, dynamic> json) => ModelKullanici(
        id: json["ID"],
        kullaniciAdSoyad: json["KullaniciAdSoyad"],
        parola: json["Parola"],
        kayitTarihi: json["KayitTarihi"],
        kayitYapan: json["KayitYapan"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "KullaniciAdSoyad": kullaniciAdSoyad,
        "Parola": parola,
        "KayitTarihi": kayitTarihi,
        "KayitYapan": kayitYapan,
    };
}
