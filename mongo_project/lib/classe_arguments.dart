import 'zModels/mongodb_model_agencia.dart';
import 'zModels/mongodb_model_banco.dart';
import 'zModels/mongodb_model_client.dart';
import 'zModels/mongodb_model_conta_cli.dart';
import 'zModels/mongodb_model_transacoes.dart';

class ClassArguments {
  MongoDbModelAgencia? dataAgencia;
  MongoDbModelBanco? dataBanco;
  MongoDbModelClient? dataClient;
  MongoDbModelContaCli? dataContaCli;
  MongoDbModelTransacoes? dataTransacoes;
}
