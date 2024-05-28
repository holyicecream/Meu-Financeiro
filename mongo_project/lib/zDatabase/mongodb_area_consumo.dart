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

// // class MongoDatabaseAgencia {
// //   static dynamic db, collection;

// //   static connect2() async {
// //     db = await Db.create(mongoUrl);
// //     await db.open();
// //     collection = await db.collection(collectionAgencias);
// //     // //print(await collection.find().toList());
// //   }

// //   static Future<List<Map<String, dynamic>>> getData() async {
// //     collection = await db.collection(collectionAgencias);
// //     final arrData = await collection.find().toList();
// //     return arrData;
// //   }

// //   static Future<void> insert(MongoDbModelAgencia data) async {
// //     try {
// //       var result = await collection.insertOne(data.toJson());
// //       if (result.isSucces) {
// //         // return //print('result');
// //       } else {
// //         // return //print('not result');
// //       }
// //     } catch (e) {
// //       // return //print(e.toString());
// //     }
// //   }

// //   static Future<void> update(MongoDbModelAgencia data) async {
// //     await collection.update(
// //         where.eq("_id", data.id), modify.set('Nome', data.nome));
// //     await collection.update(where.eq("_id", data.id),
// //         modify.set('Numero_Agencia', data.numeroAgencia));
// //     await collection.update(
// //         where.eq("_id", data.id), modify.set('Telefone', data.telefone));
// //     await collection.update(
// //         where.eq("_id", data.id), modify.set('Endereco', data.endereco));
// //     await collection.update(
// //         where.eq("_id", data.id), modify.set('Email', data.email));
// //     await collection.update(
// //         where.eq("_id", data.id), modify.set('CNPJ', data.cnpj));
// //   }

// //   // void adicionaUm(
// //   //     {required String userLogin,
// //   //     required String nome,
// //   //     required String email}) async {
// //   //   await collection
// //   //       .insertOne({"username": userLogin, "name": nome, "email": email});
// //   // }

// //   // void adicionaVarios({required int quantidade}) async {
// //   //   for (var i = 0; i < quantidade; i++) {
// //   //     String? userLogin = stdin.readLineSync();
// //   //     String? nome = stdin.readLineSync();
// //   //     String? email = stdin.readLineSync();
// //   //     await collection
// //   //         .insertOne({"username": userLogin, "name": nome, "email": email});
// //   //   }
// //   // }

// //   // void atualizaDados({required String? a}) async {
// //   //   //print(a);
// //   //   await collection.update(
// //   //       where.eq("username", "QueNome"), modify.set("name", "Pedro né"));
// //   // }

// //   // void deletaDados({required String? a}) async {
// //   //   //print(a);
// //   //   await collection.deleteOne(where.eq("username", "QueNome"));
// //   // }
// // }