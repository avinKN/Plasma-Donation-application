import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class FirebaseActions {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<AppUser> get userStream {
    return _auth.authStateChanges().map((User user) => _realUser(user));
  }

  AppUser _realUser(User user) {
    return user != null ? AppUser(userID: user.uid) : null;
  }

  //////////////////////

  final CollectionReference appuser =
  FirebaseFirestore.instance.collection('Users');
  Future createNewUser(
      String name,
      String phone,
      String uid,
      String city,
      String blood,
      String email,
      String password,
      ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await createUser(name, email, phone, user.uid,blood,city);

      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createUser(
      String name, String email, String phone, String uid, String blood,String city ) async {
    return await appuser.doc(uid).set({
      'Name': name,
      'City':city,
      "Email": email,
      'Phone': phone,
      "UserID": uid.toString(),
      "Blood":blood
    });
  }



// Register Method


// SignOut Method
  Future<void> signOut() async {
    return await _auth.signOut();
  }

// SignIn Method
  Future userLogin(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = res.user;
      return AppUser(userID: user.uid);
    } catch (errer) {
      print(errer.toString());
      return null;
    }
  }
}

class PostsInformation {
  final CollectionReference postList =
      FirebaseFirestore.instance.collection('Posts');

  Future getPosts() async {
    List getPostData = [];

    try {
      await postList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          getPostData.add(element.data());
        });
      });
      return getPostData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
