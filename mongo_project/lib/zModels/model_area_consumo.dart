// To parse this JSON data, do
//
//     final areaConsumo = areaConsumoFromJson(jsonString);

import 'dart:convert';

MongoDbModelAreaConsumo areaConsumoFromJson(String str) =>
    MongoDbModelAreaConsumo.fromJson(json.decode(str));

String areaConsumoToJson(MongoDbModelAreaConsumo data) =>
    json.encode(data.toJson());

class MongoDbModelAreaConsumo {
  int? codAreaConsumo;
  String? areaConsumo;

  MongoDbModelAreaConsumo({
    this.codAreaConsumo,
    this.areaConsumo = '',
  });

  factory MongoDbModelAreaConsumo.fromJson(Map<String, dynamic> json) =>
      MongoDbModelAreaConsumo(
        codAreaConsumo: json["cod_area_consumo"],
        areaConsumo: json["area_consumo"],
      );

  Map<String, dynamic> toJson() => {
        "cod_area_consumo": codAreaConsumo,
        "area_consumo": areaConsumo,
      };
}
