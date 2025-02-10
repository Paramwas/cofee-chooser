class Users {
  final String uid;

  Users({required this.uid});
}

class Userdata {
  final String uid;
  final String name;
  final String strength;
  final String sugars;

  Userdata(
      {required this.name,
      required this.strength,
      required this.sugars,
      required this.uid});
}
