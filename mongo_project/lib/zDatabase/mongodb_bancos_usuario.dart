import 'package:mongo_dart/mongo_dart.dart';

import '/zModels/model_bancos_usuario.dart';
import 'conexao/const_database.dart';

class MongoDatabaseBancosUsuario {
  static dynamic db, collection;

  static Future<void> connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionBancosUsuario);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionBancosUsuario);
    final arrData = await collection.find().toList();
    return arrData;
  }

  static Future<void> insert(MongoDbModelBancosUsuario data) async {
    try {
      final result = await collection.insertOne(data.toJson());
      if (result.isSucces) {
      } else {}
    } catch (e) {
      //print(e.toString());
    }
  }
}
