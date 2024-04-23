class UserCreationRequest {
  final String username;
  final String firstname;
  final String lastname;
  final String role;
  final String email;
  final String password;
  final String address;

  UserCreationRequest({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.email,
    required this.password,
    required this.address,
  });

  factory UserCreationRequest.fromJson(Map<String, dynamic> json) {
    return UserCreationRequest(
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
      address: json['adress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'role': role,
      'email': email,
      'password': password,
      'adress': address,
    };
  }
}
