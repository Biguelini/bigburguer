class Garcom {
  String? login;
  String? senha;
  String? nome;
  String? telefone;
  String? cpf;
  Garcom(
    this.login,
    this.senha,
    this.nome,
    this.telefone,
    this.cpf,
  );
  Garcom.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    senha = json['senha'];
    nome = json['nome'];
    telefone = json['telefone'];
    cpf = json['cpf'];
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "login": login,
      "senha": senha,
      "nome": nome,
      "telefone": telefone,
      "cpf": cpf,
    };
  }
}
