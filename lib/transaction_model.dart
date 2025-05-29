import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class TransactionModel extends Equatable {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _purpose = "".obs;
  String get purpose => _purpose.value;
  set purpose(String value) => _purpose.value = value;

  final _amount = 0.0.obs;
  double get amount => _amount.value;
  set amount(double value) => _amount.value = value;

  final _currency = CurrencyEnums.USD.obs;
  CurrencyEnums get currency => _currency.value;
  set currency(CurrencyEnums value) => _currency.value = value;

  final _expenseType = ExpenseTypeEnums.food.obs;
  ExpenseTypeEnums get expenseType => _expenseType.value;
  set expenseType(ExpenseTypeEnums value) => _expenseType.value = value;

  final _reason = "".obs;
  String get reason => _reason.value;
  set reason(String value) => _reason.value = value;

  final _paymentMethod = PaymentMethodEnums.mobilePayment.obs;
  PaymentMethodEnums get paymentMethod => _paymentMethod.value;
  set paymentMethod(PaymentMethodEnums value) => _paymentMethod.value = value;

  final _isOthersInvolved = false.obs;
  bool get isOthersInvolved => _isOthersInvolved.value;
  set isOthersInvolved(bool value) => _isOthersInvolved.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  final _time = "".obs;
  String get time => _time.value;
  set time(String value) => _time.value = value;

  final _location = "".obs;
  String get location => _location.value;
  set location(String value) => _location.value = value;

  final _latitude = 0.0.obs;
  double get latitude => _latitude.value;
  set latitude(double value) => _latitude.value = value;

  final _longitude = 0.0.obs;
  double get longitude => _longitude.value;
  set longitude(double value) => _longitude.value = value;

  final _othersInvolved = <UserModel>[].obs;
  List<UserModel> get othersInvolved => _othersInvolved;
  set othersInvolved(List<UserModel> value) => _othersInvolved.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  final _createdBy = UserModel().obs;
  UserModel get createdBy => _createdBy.value;
  set createdBy(UserModel value) => _createdBy.value = value;

  final _updatedBy = UserModel().obs;
  UserModel get updatedBy => _updatedBy.value;
  set updatedBy(UserModel value) => _updatedBy.value = value;

  final _status = TransactionStatusEnums.success.obs;
  TransactionStatusEnums get status => _status.value;
  set status(TransactionStatusEnums value) => _status.value = value;

  final _transactionType = TransactionTypeEnums.expense.obs;
  TransactionTypeEnums get transactionType => _transactionType.value;
  set transactionType(TransactionTypeEnums value) =>
      _transactionType.value = value;

  TransactionModel();

  factory TransactionModel.create({
    required String purpose,
    required double amount,
    required CurrencyEnums currency,
    required ExpenseTypeEnums expenseType,
    required String reason,
    required PaymentMethodEnums paymentMethod,
    required DateTime date,
    required String time,
    required String location,
    required double latitude,
    required double longitude,
    required UserModel createdBy,
    required UserModel updatedBy,
    required DateTime updatedAt,
    required TransactionStatusEnums status,
    required TransactionTypeEnums transactionType,
    bool? isOthersInvolved,
    List<UserModel>? othersInvolved,
  }) {
    var transaction = TransactionModel();
    transaction.id = Uuid().v8();
    transaction.purpose = purpose;
    transaction.amount = amount;
    transaction.currency = currency;
    transaction.expenseType = expenseType;
    transaction.reason = reason;
    transaction.paymentMethod = paymentMethod;
    transaction.date = date;
    transaction.time = time;
    transaction.location = location;
    transaction.latitude = latitude;
    transaction.longitude = longitude;
    transaction.createdAt = DateTime.now();
    transaction.createdBy = createdBy;
    transaction.updatedAt = updatedAt;
    transaction.updatedBy = updatedBy;
    transaction.status = status;
    transaction.transactionType = transactionType;
    transaction.isOthersInvolved = isOthersInvolved ?? false;
    transaction.othersInvolved = othersInvolved ?? [];
    return transaction;
  }

  static TransactionEntity toEntity(TransactionModel model) {
    var entity = TransactionEntity();

    entity.id = model.id;
    entity.purpose = model.purpose;
    entity.amount = model.amount;
    entity.currency = model.currency;
    entity.expenseType = model.expenseType;
    entity.reason = model.reason;
    entity.paymentMethod = model.paymentMethod;
    entity.isOthersInvolved = model.isOthersInvolved;
    entity.date = model.date;
    entity.time = model.time;
    entity.location = model.location;
    entity.latitude = model.latitude;
    entity.longitude = model.longitude;
    entity.othersInvolved =
        model.othersInvolved
            .map(
              (element) => UserEntity.create(
                id: element.id,
                name: element.name,
                email: element.email,
                phone: element.phone,
                password: element.phone,
                address: element.address,
                profilePicture: element.profilePicture,
                gender: element.gender,
                createdAt: element.createdAt,
                updatedAt: element.updatedAt,
                role: element.role,
              ),
            )
            .toList();
    entity.createdBy = UserModel.toEntity(model.createdBy);
    entity.updatedBy = UserModel.toEntity(model.updatedBy);
    entity.createdAt = model.createdAt;
    entity.updatedAt = model.updatedAt;
    entity.status = model.status;
    entity.transactionType = model.transactionType;
    return entity;
  }

  @override
  List<Object?> get props => [
    id,
    purpose,
    amount,
    currency,
    expenseType,
    reason,
    paymentMethod,
    isOthersInvolved,
    date,
    time,
    location,
    latitude,
    longitude,
    othersInvolved,
    createdAt,
    updatedAt,
    createdBy,
    updatedBy,
    status,
    transactionType,
  ];
}
