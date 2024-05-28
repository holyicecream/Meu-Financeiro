import 'package:mongo_dart/mongo_dart.dart';
import '../zModels/model_clientes.dart';
import 'conexao/const_database.dart';

class MongoDatabaseClientes {
  static dynamic db, collection;

  static Future<void> connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionClientes);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionClientes);
    final arrData = await collection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> tryLogin(
      String email, String senha) async {
    collection = await db.collection(collectionClientes);
    final arrData = await collection.find().toList();
    print(arrData[0]['cod_cliente']);
    return arrData;
  }

  static Future<void> insert(MongoDbModelClientes data) async {
    try {
      final result = await collection.insertOne(data.toJson());
      if (result.isSucces) {
        // return //print('result');
      } else {
        // return //print('not result');
      }
    } catch (e) {
      // return //print(e.toString());
    }
  }

  static Future<void> updateNome(MongoDbModelClientes data) async {
    await collection.update(where.eq("cod_cliente", data.codCliente),
        modify.set('nome_cliente', data.nomeCliente));
  }
  static Future<void> updateSenha(MongoDbModelClientes data) async {
    await collection.update(where.eq("cod_cliente", data.codCliente),
        modify.set('senha', data.senha));
  }
}
