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
    final arrData = await collection.find({'cod_cliente':cod}).toList();
    return arrData;
  }

  static Future<void> insert(MongoDbModelExtrato data) async {
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