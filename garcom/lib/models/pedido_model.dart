class Pedido {
  int? id;
  int? idMesa;
  int? idPrato;
  String? status;
  Pedido(
    this.id,
    this.idMesa,
    this.idPrato,
    this.status,
  );
  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMesa = json['idMesa'];
    idPrato = json['idPrato'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "idMesa": idMesa,
      "idPrato": idPrato,
      "status": status,
    };
  }
}
