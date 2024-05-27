import 'package:mongo_dart/mongo_dart.dart';

import '/const.dart';
import '../zModels/mongodb_model_transacoes.dart';

class MongoDatabaseTransacoes {
  static dynamic db, collection;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionTransacoes);
    // //print(await collection.find().toList());
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionTransacoes);
    final arrData = await collection.find().toList();
    return arrData;
  }
  static Future<List<Map<String, dynamic>>> getDataByAccount(int numeroConta) async {
    collection = await db.collection(collectionTransacoes);
    final arrData = await collection.find({'Numero_Conta': numeroConta}).toList();
    return arrData;
  }

  static Future<void> insert(MongoDbModelTransacoes data) async {
    try {
      await collection.insertOne(data.toJson());
      // if (result.isSucces) {
      //   return //print('result');
      // } else {
      //   return //print('not result');
      // }
    } catch (e) {
      // return //print(e.toString());
    }
  }

  // static Future<void> update(MongoDbModelTransacoes data) async {
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Nome', data.data));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Email', data.numeroConta));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Endereco', data.tipoConta));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Telefone', data.chavePix));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Endereco', data.saldo));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('CNPJ', data.numeroAgencia));
  // }

  // void adicionaUm(
  //     {required String userLogin,
  //     required String nome,
  //     required String email}) async {
  //   await collection
  //       .insertOne({"username": userLogin, "name": nome, "email": email});
  // }

  // void adicionaVarios({required int quantidade}) async {
  //   for (var i = 0; i < quantidade; i++) {
  //     String? userLogin = stdin.readLineSync();
  //     String? nome = stdin.readLineSync();
  //     String? email = stdin.readLineSync();
  //     await collection
  //         .insertOne({"username": userLogin, "name": nome, "email": email});
  //   }
  // }

  // void atualizaDados({required String? a}) async {
  //   //print(a);
  //   await collection.update(
  //       where.eq("username", "QueNome"), modify.set("name", "Pedro né"));
  // }

  // void deletaDados({required String? a}) async {
  //   //print(a);
  //   await collection.deleteOne(where.eq("username", "QueNome"));
  // }
}
