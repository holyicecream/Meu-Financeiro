import 'package:fixnum/fixnum.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '/const.dart';
import '../zModels/mongodb_model_conta_cli.dart';

class MongoDatabaseContaCli {
  static dynamic db, collection;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = await db.collection(collectionContaCli);
    // //print(await collection.find().toList());
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    collection = await db.collection(collectionContaCli);
    final arrData = await collection.find().toList();
    return arrData;
  }
  static Future<List<Map<String, dynamic>>> getDataByCPF(Int64 cpf) async {
    collection = await db.collection(collectionContaCli);
    final arrData = await collection.find({'CPF': cpf}).toList();
    return arrData;
  }

  static Future<void> updateSaldoByNumeroConta(
    int numeroConta, int numeroContaDestinatario, double saldo, double saldoDestinatario, double valor,) async {
    await collection.update(where.eq("Numero_Conta", numeroConta), modify.set('Saldo', (saldo - valor)));
    
    await collection.update(where.eq("Numero_Conta", numeroContaDestinatario), modify.set('Saldo', (saldoDestinatario + valor)));
    }

  static Future<void> insert(MongoDbModelContaCli data) async {
    try {
      await collection.insertOne(data.toJson());
    } catch (e) {
      // return //print(e.toString());
    }
  }

  // static Future<void> update(MongoDbModelContaCli data) async {
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Numero_Conta', data.numeroConta));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Tipo_Conta', data.tipoConta));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Chave_Pix', data.chavePix));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Saldo', data.saldo));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('Limite', data.limite));
  //   await collection.update(
  //       where.eq("_id", data.id), modify.set('CPF', data.cpf));
  //   await collection.update(where.eq("_id", data.id),
  //       modify.set('Numero_Agencia', data.numeroAgencia));
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
