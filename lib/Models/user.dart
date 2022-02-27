// thực thể user dùng trong app

class Agency {
  String name;
  String nameOwn;
  String phone;
  DateTime dateJoin;
  String province;
  String district;
  String ward;
  String extraInfoOfAddress;
  String address;
  String companyName;

  Agency(
    this.name, 
    this.nameOwn, 
    this.phone,
    this.dateJoin,
    this.province,
    this.district,
    this.ward,
    this.extraInfoOfAddress,
    this.address,
    this.companyName,
  );
}