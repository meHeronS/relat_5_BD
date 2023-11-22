class Note {
  int? id;
  String name;
  String adress;
  String cpf;
  String mail;
  String phone;

  Note({
    this.id,
    required this.name,
    required this.adress,
    required this.cpf,
    required this.mail,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'adress': adress,
      'cpf': cpf,
      'mail': mail,
      'phone': phone,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      name: map['name'],
      adress: map['adress'],
      phone: map['phone'],
      cpf: map['cpf'],
      mail: map['mail'],

    );
  }
}