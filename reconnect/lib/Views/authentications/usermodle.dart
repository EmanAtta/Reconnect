class UserModel {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
  UserModel.fromJson(Map<String, Object> json)
      : this(
          id: json['id']!as String?,
          firstname: json['firstname']! as String,
          lastname: json['lastname']! as String,
          email: json['email']! as String,
          password: json['password']! as String,
        );
  Map<String, Object> toJson(){
    return {
      
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }
}
