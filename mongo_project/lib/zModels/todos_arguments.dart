import '/zModels/model_area_consumo.dart';
import '/zModels/model_bancos.dart';
import '/zModels/model_bancos_usuario.dart';
import '/zModels/model_clientes.dart';
import '/zModels/model_extrato.dart';
import '/zModels/model_tipo_transacao.dart';

class TodosArguments {
  MongoDbModelAreaConsumo dataAreaConsumo;
  MongoDbModelBancosUsuario dataBancosUsuario;
  MongoDbModelBancos dataBancos;
  MongoDbModelClientes dataClientes;
  MongoDbModelExtrato dataExtrato;
  MongoDbModelTipoTransacao dataTransacao;
  double salario;

  TodosArguments({
    required this.dataAreaConsumo,
    required this.dataBancosUsuario,
    required this.dataBancos,
    required this.dataClientes,
    required this.dataExtrato,
    required this.dataTransacao,
    this.salario = 0,
  });
}
