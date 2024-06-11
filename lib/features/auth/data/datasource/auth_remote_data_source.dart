import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone/features/auth/presentation/screens/otp_screen.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel?> signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber});

  Future<UserModel?> getCurrentUserData();
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuthInstance;
  final FirebaseFirestore firebaseFirestoreInstance;

  FirebaseAuthRemoteDataSource(
      this.firebaseAuthInstance, this.firebaseFirestoreInstance);

  @override
  Future<UserModel?> getCurrentUserData() {
    // TODO: implement getCurrentUserData
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) async {
    PhoneAuthCredential? phoneAuthCredential;
    await firebaseAuthInstance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneCredential) {
        phoneAuthCredential = phoneCredential;
      },
      verificationFailed: (error) {
        throw Exception(error.message);
      },
      codeSent: (verificationId, forceResendingToken) async {
        Navigator.pushNamed(context, OtpScreen.routeName, arguments: verificationId);

        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        // await firebaseAuthInstance.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    if (phoneAuthCredential == null) {
      return null;
    }
    final model = UserModel(phoneNumber: phoneNumber);
    return model;
  }
}
