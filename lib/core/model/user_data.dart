class UserData {
  final String name;
  final String address;
  final String email;
  final String mobileNum;

  UserData(
      {required this.name,
      required this.address,
      required this.email,
      required this.mobileNum});

  factory UserData.fromJson(jsonData) {
    return UserData(
        name: jsonData['name'],
        address: jsonData['address'],
        email: jsonData['email'],
        mobileNum: jsonData['mobileNum']);
  }
}
