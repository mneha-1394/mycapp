import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String uid;
  final String email;
  final String department;
  final String gender;
  final String phonenumber;
  final String photoUrl;

  const User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.department,
      required this.gender,
      required this.phonenumber,
      required this.photoUrl,
  });
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot["Name"],
        uid: snapshot["Uid"],
        email: snapshot["Email"],
        department: snapshot["Department"],
        gender: snapshot["Gender"],
        phonenumber: snapshot["Phone Number"],
        photoUrl: snapshot["PhotoUrl"],
        );
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Uid": uid,
        "Email": email,
        "Gender": gender,
        "Phone Number": phonenumber,
        "Department": department,
        "PhotoUrl": photoUrl,

      };
}
