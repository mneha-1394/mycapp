import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/resources/storage_methods.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user details
  Future<model.User?> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =await _firestore.collection('users').doc(currentUser.uid).get(); 
      print("getuserdone");
      
       return model.User.fromSnap(documentSnapshot);
  }


  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> verficationSignup(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isEmpty) {
        await _auth.currentUser!.sendEmailVerification();
        bool isverified = _auth.currentUser!.emailVerified;
        if (isverified == true) {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          print(cred.user);
          res = "success";
        } else {
          res = "Email not verified";
        }
      } else {
        res = "Please enter all details";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> siginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
        
        
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> save(
      {required String name,
      required String email,
      required String department,
      required String gender,
      required String phonenumber,
      required Uint8List file}) async {
    String res = "Data Not uploaded";
    try {
      if (name.isNotEmpty
          // ignore: unnecessary_null_comparison
          ||
          email.isNotEmpty ||
          department.isNotEmpty ||
          gender.isNotEmpty ||
          phonenumber.isNotEmpty ||
          file != null) {
        User? currentUser = _auth.currentUser;
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          name: name,
          email: email,
          uid: currentUser!.uid,
          department: department,
          gender: gender,
          phonenumber: phonenumber,
          photoUrl: photoUrl,
        );
        await _firestore
            .collection("users")
            .doc(currentUser.uid)
            .set(user.toJson());
        res = "Data Uploaded";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future googleSiginIn() async {
    final GoogleSignIn gSignin = GoogleSignIn();
    try {
      final GoogleSignInAccount? gSiginAcc = await gSignin.signIn();
      if (gSiginAcc != null) {
        final GoogleSignInAuthentication gSiginAuth =
            await gSiginAcc.authentication;
        final AuthCredential cred = GoogleAuthProvider.credential(
            idToken: gSiginAuth.idToken, accessToken: gSiginAuth.accessToken);
        await _auth.signInWithCredential(cred);
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<String> resetpassword({required String email}) async {
    String res = "Error Sending password reset email";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
