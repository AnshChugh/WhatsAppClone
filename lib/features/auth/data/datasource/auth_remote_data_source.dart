import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone/features/auth/presentation/screens/otp_screen.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber});
  Future<void> verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String otp});
  Future<UserModel?> getCurrentUserData();

  Future<UserModel> uploadUserData(
      {required String name,
      required File? profilePic,
      required BuildContext context});
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuthInstance;
  final FirebaseFirestore firebaseFirestoreInstance;
  final FirebaseStorage firebaseStorageInstance;

  FirebaseAuthRemoteDataSource(this.firebaseAuthInstance,
      this.firebaseFirestoreInstance, this.firebaseStorageInstance);

  @override
  Future<UserModel?> getCurrentUserData() {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String otp}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await firebaseAuthInstance.signInWithCredential(credential);
  }

  @override
  Future<void> signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) async {
    await firebaseAuthInstance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneCredential) async {
        await firebaseAuthInstance.signInWithCredential(phoneCredential);
      },
      verificationFailed: (error) {
        throw Exception(error.message);
      },
      codeSent: (verificationId, forceResendingToken) async {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return OtpScreen(verificationId: verificationId);
          },
        ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Future<UserModel> uploadUserData(
      {required String name,
      required File? profilePic,
      required BuildContext context}) async {
    String uid = firebaseAuthInstance.currentUser!.uid;
    String photoUrl =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
    if (profilePic != null) {
      photoUrl = await storeFileToFirebase(
        profilePic,
      );
    }

    final user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: firebaseAuthInstance.currentUser!.phoneNumber!,
        groupId: []);

    await firebaseFirestoreInstance
        .collection('users')
        .doc(uid)
        .set(user.toMap());

    return user;
  }

  Future<String> storeFileToFirebase(File file) async {
    try {
      String ref = firebaseAuthInstance.currentUser!.uid;
      UploadTask uploadTask =
          firebaseStorageInstance.ref(ref).child(ref).putFile(file);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw e.toString();
    }
  }
}
