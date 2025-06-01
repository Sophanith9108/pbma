import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberController extends GetxController {
  final MemberRepository _memberRepository = Get.put(MemberRepository());

  final _members = <UserModel>[].obs;
  List<UserModel> get members => _members;
  set members(List<UserModel> value) => _members.value = value;

  Future<void> onRefreshing() async {
    Get.back();
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();

      AppUtils.showSuccess('Successfully refresing...');

      setData();
    });
  }

  Future<void> onRemoveMember(int index) async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();

      AppUtils.showSuccess('Successfully removing member...');
      return true;
    });
  }

  Future<void> gotoCreateMember() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      Get.toNamed(AppRoutes.createMember)?.then((value) {
        if (value != null && value) {
          onRefreshing();
        }
      });
    });
  }

  Future<void> setData() async {
    members = await _memberRepository.gets() ?? [];
    members = members.reversed.toList();
  }

  @override
  void onInit() {
    setData();
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
}
