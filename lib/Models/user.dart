class User {
  final String uid;
  String firstName;
  String lastName;
  String eMail;
  String username;
  String password;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.eMail,
    this.username,
    this.password,
  });

  Map<String, dynamic> get map {
    return {
      "uid":uid,
      "firstName": firstName,
      "lastName": lastName,
      "eMail": eMail,
      "username": username,
      "password": password,
    };
  }
}
