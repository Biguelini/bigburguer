class Garcom {
  String? login;
  String? senha;
  Garcom(
    this.login,
    this.senha,
  );
  Garcom.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    senha = json['senha'];
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "login": login,
      "senha": senha,
    };
  }
}
