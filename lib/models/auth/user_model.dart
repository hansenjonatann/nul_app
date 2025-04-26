class UserModel {
  String username;
  String email;
  String phone;
  String password;
  String confirmationPassword;

  UserModel(
      {required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.confirmationPassword});
}
