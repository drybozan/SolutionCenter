
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/user_controller.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/user_model.dart';

class AuthService {
  // create instance of firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  // check if it is signed in
  bool isSignedIn() {
    bool isSigned = false;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSigned = false;
      } else {
        isSigned = true;
      }
    });

    return isSigned;
  }

  //get user by id
  Future<UserModel?> getUserInfo(String id) async {
    try {
      var data = await db.collection("users").doc(id).get();

      return UserModel.fromJson(data.data()!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }


  Future<void> addCategoryToUser(CategoryModel category) async {
    try {
      var data = await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('category')
          .doc(category.categoryId)
          .set(category.toJson());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesOfUser(){
      var stream = db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('category').snapshots();
      return stream;
  }

  // get user category
  Future<List<CategoryModel>> getUserCategory() async {
    List<CategoryModel> categoryList = [];
    try {
       await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('category')
          .get()
          .then((event) {
        for (var doc in event.docs) {
          categoryList.add(CategoryModel.fromJson(doc.data()));
        }
      });

      return categoryList;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return categoryList;
    }
  }

  //delete category from user
  Future<void> deleteCategoryToUser(CategoryModel categoryModel) async {
    try {
      var data = await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('category')
          .doc(categoryModel.categoryId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //get user
  Stream<User?> get user {
    return auth.authStateChanges();
  }

  User? getUser() {
    return auth.currentUser;
  }

  Future<bool> forgetPassword(String email, BuildContext context) async {
    var messageStatus = Provider.of<UserController>(context, listen: false);
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      messageStatus.currentMessage('The email is send');
      return true;
    } catch (e) {
      //print(e);
      messageStatus.currentMessage('$e');
      return false;
    }
  }

  // sign up
  Future<bool> signUp(UserModel user, BuildContext context) async {
    var messageStatus = Provider.of<UserController>(context, listen: false);
    final langMessage =
    Provider.of<LocalizationController>(context, listen: false)
        .getLanguage();
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      _addUserToFireStore(
        UserModel(
          username: user.username,
          email: user.email,
          password: user.password,
          admin: user.admin,
          userId: userCredential.user!.uid,
        ),
      );
      messageStatus.currentMessage('Signed up successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        messageStatus.currentMessage('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        messageStatus.currentMessage(langMessage.alreadyExistMessage!);
        return false;
      } else {
        messageStatus.currentMessage('$e');
        return false;
      }
    } catch (e) {
      messageStatus.currentMessage('$e');
      return false;
    }
  }

  //sign in
  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    var messageStatus = Provider.of<UserController>(context, listen: false);
    final langMessage =
    Provider.of<LocalizationController>(context, listen: false)
        .getLanguage();
    try {
      // ignore: unused_local_variable
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      messageStatus.currentMessage(langMessage.loginMessage!);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       // messageStatus.currentMessage(langMessage.userNotFound!);
        return false;
      } else if (e.code == 'wrong-password') {
        //messageStatus.currentMessage(langMessage.wrongPasswordMessage!);
        return false;
      } else {
        messageStatus.currentMessage('$e');
        return false;
      }
    }
  }

  // get current user data
  User? getCurrentUser() {
    return auth.currentUser;
  }

  //sign out
  Future<bool> signOut(BuildContext context) async {
    var messageStatus = Provider.of<UserController>(context, listen: false);
    final langMessage =
    Provider.of<LocalizationController>(context, listen: false)
        .getLanguage();
    await auth.signOut();
    if (isSignedIn() == false) {
      messageStatus.currentMessage(langMessage.signOutMessage!);
      return true;
    } else {
      messageStatus.currentMessage(langMessage.signOutErrorMessage!);
      return false;
    }
  }

  void _addUserToFireStore(UserModel user) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(AuthService().getCurrentUser()!.uid)
        .set(user.toJson());
  }
}
