class User {
  String firstName;
  String lastName;
  String eMail;
  String username;
  String password;

  User({
    this.firstName,
    this.lastName,
    this.eMail,
    this.username,
    this.password,
  });

  Map<String, dynamic> get map {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "eMail": eMail,
      "username": username,
      "password": password,
    };
  }
}
