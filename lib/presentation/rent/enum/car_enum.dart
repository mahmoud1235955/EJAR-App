enum CarEnum { Newproduct, NotNew }

extension carStatus on CarEnum {
  String get arabicStatus {
    switch (this) {
      case CarEnum.Newproduct:
        return "جديد";
      case CarEnum.NotNew:
        return "مستعمل";
    }
  }
}
