import 'dart:convert';

class HesapHareketleriModel {
    int? id;
    String? name;
    String? description;
    int? hesapId;
    int? kullaniciId;
    int? miktar;
    dynamic kayitYapan;
    DateTime? kayitTarihi;
    dynamic degisiklikYapan;
    DateTime? degisiklikTarihi;
    String? hareketTuru;
    String? hesapAdi;
    String? baslangicTarihi;
    String? bitisTarihi;
 

    HesapHareketleriModel({
        this.id,
        this.name,
        this.description,
        this.hesapId,
        this.kullaniciId,
        this.miktar,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
        this.hareketTuru,
        this.hesapAdi,
        this.baslangicTarihi,
        this.bitisTarihi
    });

    HesapHareketleriModel copyWith({
        int? id,
        String? name,
        String? description,
        int? hesapId,
        int? kullaniciId,
        int? miktar,
        dynamic kayitYapan,
        DateTime? kayitTarihi,
        dynamic degisiklikYapan,
        DateTime? degisiklikTarihi,
        String? hareketTuru,
        String? hesapAdi,
        String? baslangicTarihi,
        String? bitisTarihi,
    }) => 
        HesapHareketleriModel(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            hesapId: hesapId ?? this.hesapId,
            kullaniciId: kullaniciId ?? this.kullaniciId,
            miktar: miktar ?? this.miktar,
            kayitYapan: kayitYapan ?? this.kayitYapan,
            kayitTarihi: kayitTarihi ?? this.kayitTarihi,
            degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
            degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
            hareketTuru: hareketTuru ?? this.hareketTuru,
            hesapAdi: hesapAdi ?? this.hesapAdi,
            bitisTarihi: bitisTarihi ?? this.bitisTarihi,
            baslangicTarihi: baslangicTarihi ?? this.baslangicTarihi,
        );

    factory HesapHareketleriModel.fromRawJson(String str) => HesapHareketleriModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HesapHareketleriModel.fromJson(Map<String, dynamic> json) => HesapHareketleriModel(
        id: json["ID"],
        name: json["Name"],
        description: json["Description"],
        hesapId: json["HesapID"],
        kullaniciId: json["KullaniciID"],
        miktar: json["Miktar"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"] == null ? null : DateTime.parse(json["KayitTarihi"]),
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"] == null ? null : DateTime.parse(json["DegisiklikTarihi"]),
        hareketTuru: json["HareketTuru"],
        hesapAdi: json["HesapAdi"],
        baslangicTarihi: json["BaslangicTarihi"],
        bitisTarihi: json["BitisTarihi"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Description": description,
        "HesapID": hesapId,
        "KullaniciID": kullaniciId,
        "Miktar": miktar,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi?.toIso8601String(),
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi?.toIso8601String(),
        "HareketTuru": hareketTuru,
        "HesapAdi": hesapAdi,
        "BitisTarihi":bitisTarihi,
        "BaslangicTarihi":baslangicTarihi
        
    };
}
