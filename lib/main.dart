import 'package:flutter/material.dart';
import 'package:relat_5/flutter_sqlite_crud/database_helper.dart';
import 'package:relat_5/flutter_sqlite_crud/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite CRUD',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<Note> _notes = [];

  final TextEditingController _name   = TextEditingController();
  final TextEditingController _adress = TextEditingController();
  final TextEditingController _cpf    = TextEditingController();
  final TextEditingController _mail   = TextEditingController();
  final TextEditingController _phone  = TextEditingController();


  final String task_name       = '';
  final String task_adress     = '';
  final String task_cpf        = '';
  final String task_mail       = '';
  final String task_phone      = '';

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _consultar_bd();
  }

  void _loadNotes() async {
    List<Note> notes = await dbHelper.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }

  void _consultar_bd() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Banco de Dados:');
    todasLinhas.forEach((row) => print(row));
  }

  void _addNote() async {

    Note newNote = Note(
      name: _name.text,
      adress: _adress.text,
      cpf: _cpf.text,
      mail: _mail.text,
      phone: _phone.text,
    );
    
    int id = await dbHelper.insert(newNote);
    setState(() {
      newNote.id = id;
      _notes.add(newNote);
      controller:  _name;
      _name.clear();
      controller:  _adress;
      _adress.clear();
      controller:  _cpf;
      _cpf.clear();
      controller:  _mail;
      _mail.clear();
      controller:  _phone;
      _phone.clear();
    });
    // imprime o banco
    _consultar_bd();
  }

  void _updateNote(int index) async {
    controller: _name;
    Note updatedNote = Note(
      id: _notes[index].id,
      name: _name.text,
      adress: _adress.text,
      cpf: _cpf.text,
      mail: _mail.text,
      phone: _phone.text,    );

    // atualiza o banco
    await dbHelper.update(updatedNote);
    setState(() {
      _notes[index] = updatedNote;
    });

    // imprime o banco
    _consultar_bd();
  }

  void _deleteNote(int index) async {
    await dbHelper.delete(_notes[index].id!);
    setState(() {
      _notes.removeAt(index);
    });

    // imprime o banco
    _consultar_bd();
  }

  //função deletar o BD
  void _deleteBD(int index) async {
    //await dbHelper.deleteTable(_notes[index].id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite CRUD'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:<Widget> [
          DrawerHeader(
            decoration: BoxDecoration(
            color: Colors.deepPurple,
        ),
            child: Text(
              'Trabalho de Persistencia de Dados',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
        ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Página Inicial'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text('Informações'),
        onTap: () {
          // Adicione a lógica para a ação quando o item for tocado
          Navigator.pop(context); // Fecha o drawer
        },
      ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // afastamente de 16 pixels nas bordas esquerda e direta
          child: Column(
            mainAxisSize: MainAxisSize.min,                   // para centralizar a linha no meio da tela
            children: [
              TextField(
                controller: _name,
                decoration:  InputDecoration(
                  labelText: 'Nome:',
                  // icone para apagar campo 'Tarefa'
                  suffixIcon: IconButton(
                    onPressed: _name.clear,
                    icon: Icon(Icons.clear,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: _adress,
                decoration:  InputDecoration(
                  labelText: 'Endereço:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _adress.clear,
                    icon: Icon(Icons.clear,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _cpf,
                decoration:  InputDecoration(
                  labelText: 'CPF:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _cpf.clear,
                    icon: Icon(Icons.clear,
                    ),
                  ),
                ),
              ),TextField(
                controller: _mail,
                decoration:  InputDecoration(
                  labelText: 'Email:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _mail.clear,
                    icon: Icon(Icons.clear,
                    ),
                  ),
                ),
              ),TextField(
                controller: _phone,
                decoration:  InputDecoration(
                  labelText: 'Telefone:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _phone.clear,
                    icon: Icon(Icons.clear,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_notes[index].name),
                      subtitle: Text(_notes[index].adress),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _updateNote(index);
                            },
                          ),
                          IconButton
                            (
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteNote(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addNote();
        },
      ),
    );
  }
}