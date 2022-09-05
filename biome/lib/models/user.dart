class User {
  final String id;

  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String senha;
  final int itens_2l;
  final int itens_500ml;
  final int pontos;
  // Demais campos

  User({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.senha,
    required this.itens_2l,
    required this.itens_500ml,
    required this.pontos,
  });

  factory User.fromJson(Map<String, dynamic?> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      senha: json['senha'],
      itens_2l: json['itens_2l'],
      itens_500ml: json['itens_500ml'],
      pontos: json['pontos'],
      // Demais campos
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'senha': senha,
      'itens_2l': itens_2l,
      'itens_500ml': itens_500ml,
      'pontos': pontos,
    };
  }

  Map<String, dynamic> idToMap() {
    return {'id': id};
  }
}
