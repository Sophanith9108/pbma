import 'package:uuid/uuid.dart';

class TransactionModel {
  String? id;
  String? title;
  String? amount;
  String? currency;
  String? category;
  String? reason;
  String? paymentMethod;
  String? date;
  String? time;
  String? location;
  bool? hasPeopleInvolved;

  TransactionModel();

  factory TransactionModel.create({
    String? title,
    String? amount,
    String? currency,
    String? category,
    String? reason,
    String? paymentMethod,
    String? date,
    String? time,
    String? location,
    bool? hasPeopleInvolved,
  }) {
    var transaction = TransactionModel();
    transaction.id = Uuid().v8();
    transaction.title = title;
    transaction.amount = amount;
    transaction.currency = currency;
    transaction.category = category;
    transaction.reason = reason;
    transaction.paymentMethod = paymentMethod;
    transaction.date = date;
    transaction.time = time;
    transaction.location = location;
    transaction.hasPeopleInvolved = hasPeopleInvolved;
    return transaction;
  }

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    currency = json['currency'];
    category = json['category'];
    reason = json['reason'];
    paymentMethod = json['paymentMethod'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    hasPeopleInvolved = json['hasPeopleInvolved'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'currency': currency,
      'category': category,
      'reason': reason,
      'paymentMethod': paymentMethod,
      'date': date,
      'time': time,
      'location': location,
      'hasPeopleInvolved': hasPeopleInvolved,
    };
  }
}
