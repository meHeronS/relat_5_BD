import 'package:flutter/material.dart';
import 'package:relat_5/flutter_sqlite_crud/database_helper.dart';
import 'package:relat_5/flutter_sqlite_crud/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite CRUD',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<Note> _notes = [];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _adress = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  final String taskName = '';
  final String taskAdress = '';
  final String taskCpf = '';
  final String taskMail = '';
  final String taskPhone = '';

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _consultarBD();
  }

  void _loadNotes() async {
    List<Note> notes = await dbHelper.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }

  void _consultarBD() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Banco de Dados:');
    for (var row in todasLinhas) {
      print(row);
    }
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
      controller: _name;
      _name.clear();
      controller:
      _adress;
      _adress.clear();
      controller:
      _cpf;
      _cpf.clear();
      controller:
      _mail;
      _mail.clear();
      controller:
      _phone;
      _phone.clear();
    });

    // imprime o banco
    _consultarBD();
  }

  void _updateNote(int index) async {
    controller:
    _name;
    _adress;
    _cpf;
    _mail;
    _phone;
    Note updatedNote = Note(
      id: _notes[index].id,
      name: _name.text,
      adress: _adress.text,
      cpf: _cpf.text,
      mail: _mail.text,
      phone: _phone.text,
    );

    // atualiza o banco
    await dbHelper.update(updatedNote);
    setState(() {
      _notes[index] = updatedNote;
    });

    // imprime o banco
    _consultarBD();
  }

  void _deleteNote(int index) async {
    await dbHelper.delete(_notes[index].id!);
    setState(() {
      _notes.removeAt(index);
    });

    // imprime o banco
    _consultarBD();
  }

  //função deletar o BD
  void _deleteBD(int index) async {
    //await dbHelper.deleteTable(_notes[index].id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SQLite CRUD'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'Trabalho de persistencia de Dados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Página Inicial'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Informações'),
              onTap: () {
                showDialog(context: context, builder: (BuildContext context){
                  return const AlertDialog(
                    title: Text('Informações'),
                    content: Text('Trabalho de Persistencia de dados, visando o uso do SQFLite.\n'
                        'Versão: 1.0\n'
                        'Data: 23/11/2023'),
                  );
                }
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_contact_cal_outlined),
              title: const Text('Integrantes'),
              onTap: () {
                showDialog(context: context, builder: (BuildContext context){
                  return const AlertDialog(
                    title: Text('Integrantes'),
                    content: Text('Heron Silva\nKaiky Rezende\nLuiza Dutra\nMaruilio Frade\nRobson Oliveira'),
                  );
                }
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Agradecimentos'),
              onTap: () {
                showDialog(context: context, builder: (BuildContext context){
                  return const AlertDialog(
                    title: Text('Agradecimentos'),
                    content: Text('João Rosado\nThales Santos\nWeuler Soares'),
                  );
                }
                );
              },
            ),

          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  16), // afastamente de 16 pixels nas bordas esquerda e direta
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // para centralizar a linha no meio da tela
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Nome:',
                  // icone para apagar campo 'Tarefa'
                  suffixIcon: IconButton(
                    onPressed: _name.clear,
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _adress,
                decoration: InputDecoration(
                  labelText: 'Endereço:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _adress.clear,
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _cpf,
                decoration: InputDecoration(
                  labelText: 'CPF:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _cpf.clear,
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _mail,
                decoration: InputDecoration(
                  labelText: 'Email:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _mail.clear,
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _phone,
                decoration: InputDecoration(
                  labelText: 'Telefone:',
                  // icone para apagar campo 'Descrição'
                  suffixIcon: IconButton(
                    onPressed: _phone.clear,
                    icon: const Icon(
                      Icons.clear,
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
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _updateNote(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
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
        child: const Icon(Icons.add),
        onPressed: () {
          _addNote();
        },
      ),
    );
  }
}
