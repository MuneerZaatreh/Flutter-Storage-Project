class Barcode {
  final int? id;
  final int code;
  final int amount;
  Barcode({required this.code, required this.amount,this.id});

  factory Barcode.fromJson(Map<String, dynamic> json) =>
      Barcode(
        id: json['id']
      ,code: json['code'], 
      amount: json['amount']);

  Map<String, dynamic> toJson() => {
    'id':id,'code': code, 'amount': amount};
}
