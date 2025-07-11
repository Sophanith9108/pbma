enum BankCardStatusEnum { active, frozen, deleted }

extension BankCardStatusEnumExtension on BankCardStatusEnum {
  String get name {
    switch (this) {
      case BankCardStatusEnum.active:
        return "Active";
      case BankCardStatusEnum.frozen:
        return "Frozen";
      case BankCardStatusEnum.deleted:
        return "Deleted";
    }
  }
}
