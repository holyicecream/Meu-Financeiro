import 'package:mongo_dart/mongo_dart.dart';

import '/zModels/model_extrato.dart';
import 'conexao/const_database.dart';

class MongoDatabaseExtrato {
  static dynamic db, collection;

  static Future<void> connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionExtrato);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionExtrato);
    final arrData = await collection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getDataByCodCli(int cod) async {
    collection = await db.collection(collectionExtrato);
    final arrData = await collection.find({'cod_cliente': cod}).toList();
    return arrData;
  }

  static Future<void> insert(MongoDbModelExtrato data) async {
    try {
      final result = await collection.insertOne(data.toJson());
      if (result.isSucces) {}
    } catch (e) {
      //print(e.toString());
    }
  }

  static Future<void> update(MongoDbModelExtrato data, String datetime) async {
    await collection.update(where.eq("registro", data.registro),
        modify.set('data', DateTime.tryParse(datetime)));
  }

  static Future<void> updatePagamento(
      MongoDbModelExtrato data, String datetime) async {
    await collection.update(where.eq("registro", data.registro),
        modify.set('data', DateTime.tryParse(datetime)));

    await collection.update(
        where.eq("registro", data.registro), modify.set('valor', data.valor));

    await collection.update(where.eq("registro", data.registro),
        modify.set('debito_credito', data.debitoCredito));

    await collection.update(where.eq("registro", data.registro),
        modify.set('descricao_transacao', data.descricaoTransacao));

    await collection.update(where.eq("registro", data.registro),
        modify.set('nome_destinatario', data.nomeDestinatario));
  }
}
