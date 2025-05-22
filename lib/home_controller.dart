import 'package:collection/collection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeController extends GetxController {
  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );

  final _transactions = <String, List<TransactionModel>>{}.obs;
  Map<String, List<TransactionModel>> get transactions => _transactions;
  set transactions(Map<String, List<TransactionModel>> value) =>
      _transactions.value = value;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setData() async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();
      await _initialized();
    });
  }

  Future<void> _initialized() async {
    var _transactions = await transactionRepository.gets() ?? [];
    transactions = _transactions
        .groupListsBy((element) {
          return element.date!;
        })
        .map((key, value) {
          return MapEntry(key, value.reversed.toList());
        });
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Fluttertoast.showToast(msg: "Done Refreshing!".tr);
      await _initialized();
      return true;
    });
  }
}
