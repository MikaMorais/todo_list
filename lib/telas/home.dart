import 'dart:convert'; //manipular json
import 'dart:io'; //manipular arquivos
import 'package:flutter/cupertino.dart'; //icons Apple
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; //armazenamento local

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = []; //lista de tarefas
  final _toDoController = TextEditingController();
  int _indexLastRemoved; //guarda o índice do último registro removido
  Map<String, dynamic> _lastRemoved; //guarda o último registro removido

  //Implementando a lógica
  //Carregar os dados do arquivo ao mudar o estado da classe
  @override
  void initState() {
    super.initState();
    _lerDados().then((value) {
      setState(() {
        _toDoList = json.decode(value);
      });
    });
  }

  // "async" - determina que um método será assíncrono, não retorna imediatemente um valor.
  //Chama o metodo e o mesmo continua trabalhando ali de fundo

  // "await" - determina que o aplicativo aguarde um retorno (resposta)
  // Determina um tempo de resposta, ou seja, está esperando uma resposta caso contrário não faz nada até receber essa resposta

  // "future" - determina que uma função vai retornar algo no futuro
  //Irá retornar algo no futuro, diferente do await ele não ficará esperando algo e responderá em algum momento futuro

  Future<String> _lerDados() async {
    try {
      final arquivo = await _abreArquivo();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> _abreArquivo() async {
    //Se não existir o arquivo, será criado
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  Future<Null> _recarregaLista() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        //ordena os checked's atualizando os que estão checados e os que não estão, levando os que não estão para baixo
        if (a['realizado'] && !b['realizado']) return 1;
        if (!a['realizado'] && b['realizado']) return -1;

        return 0;
      });
      _salvarDados();
    });
    return null;
  }

  Future<File> _salvarDados() async {
    String dados = json.encode(_toDoList);
    final arquivo = await _abreArquivo();
    return arquivo.writeAsString(dados);
  }

  //Método para adicionar as tarefas
  void _adicionaTarefa() {
    setState(() {
      Map<String, dynamic> novaTarefa = Map();
      novaTarefa['titulo'] = _toDoController.text;
      novaTarefa['realizado'] = false; //(-1)
      _toDoController.text = '';
      _toDoList.add(novaTarefa);
      _salvarDados();
    });
  }

  Widget widgetTarefa(BuildContext context, int index) {}

  @override
  Widget build(BuildContext context) {}
}
