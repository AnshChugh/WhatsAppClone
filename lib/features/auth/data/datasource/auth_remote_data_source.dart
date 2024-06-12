import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
