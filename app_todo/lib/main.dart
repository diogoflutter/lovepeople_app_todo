import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Produto {
  String nomeProduto;
}

class _HomeState extends State<Home> {
  final List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            redirectToNewPage();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              num item = index + 1;
              return Dismissible(
                key: Key(item.toString()),
                onDismissed: (dismissDirection) {
                  setState(() {
                    list.removeAt(index);
                    item = index - 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    '$item - ${list[index]}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void redirectToNewPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => Formulario(),
    ))
        .then((text) {
      if (text == null) {
        return '';
      }
      print(text);
      setState(() {
        list.add(text);
      });
    });
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _tarefa,
                  onSaved: (value) {
                    _tarefa.text = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Esse campo é obrigatório!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(_tarefa.text);
                      Navigator.of(context).pop(_tarefa.text);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
