import 'dart:convert';

class HesapModel {
    int? id;
    String? name;
    String? description;
    int? miktar;
    dynamic kullaniciId;
    dynamic hesapHareketleri;
    dynamic kullanici;
    dynamic kayitYapan;
    DateTime? kayitTarihi;
    dynamic degisiklikYapan;
    DateTime? degisiklikTarihi;

    HesapModel({
        this.id,
        this.name,
        this.description,
        this.miktar,
        this.kullaniciId,
        this.hesapHareketleri,
        this.kullanici,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
    });

    HesapModel copyWith({
        int? id,
        String? name,
        String? description,
        int? miktar,
        dynamic kullaniciId,
        dynamic hesapHareketleri,
        dynamic kullanici,
        dynamic kayitYapan,
        DateTime? kayitTarihi,
        dynamic degisiklikYapan,
        DateTime? degisiklikTarihi,
    }) => 
        HesapModel(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            miktar: miktar ?? this.miktar,
            kullaniciId: kullaniciId ?? this.kullaniciId,
            hesapHareketleri: hesapHareketleri ?? this.hesapHareketleri,
            kullanici: kullanici ?? this.kullanici,
            kayitYapan: kayitYapan ?? this.kayitYapan,
            kayitTarihi: kayitTarihi ?? this.kayitTarihi,
            degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
            degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
        );

    factory HesapModel.fromRawJson(String str) => HesapModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HesapModel.fromJson(Map<String, dynamic> json) => HesapModel(
        id: json["ID"],
        name: json["Name"],
        description: json["Description"],
        miktar: json["Miktar"],
        kullaniciId: json["KullaniciID"],
        hesapHareketleri: json["HesapHareketleri"],
        kullanici: json["Kullanici"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"] == null ? null : DateTime.parse(json["KayitTarihi"]),
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"] == null ? null : DateTime.parse(json["DegisiklikTarihi"]),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Description": description,
        "Miktar": miktar,
        "KullaniciID": kullaniciId,
        "HesapHareketleri": hesapHareketleri,
        "Kullanici": kullanici,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi?.toIso8601String(),
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi?.toIso8601String(),
    };
}
