import 'package:mongo_dart/mongo_dart.dart';

import 'conexao/const_database.dart';

class MongoDatabaseAreaConsumo {
  static dynamic db, collection;

  static Future<void> connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionAreaConsumo);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionAreaConsumo);
    final arrData = await collection.find().toList();
    return arrData;
  }
}
