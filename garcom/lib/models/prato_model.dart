class Prato {
  int? id;
  double? preco;
  String? nome;
  Prato(
    this.id,
    this.preco,
    this.nome,
  );
  Prato.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    preco = json['preco'];
    nome = json['nome'];
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "preco": preco,
      "nome": nome,
    };
  }
}
