void main() {
  final user = User(firstName: "wei", lastName: 'gao');
  user.getFullName();
  user.fullName;
}

class User {
  final String firstName;
  final String lastName;

  User({required this.firstName, required this.lastName});

  String getFullName() => '$firstName $lastName';
  String get fullName => '$firstName $lastName';
}
