import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/common/widgets/loader.dart';
import 'package:whatsapp_clone/core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/auth/presentation/bloc/auth_bloc.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void pickImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveUserData() {
    context.read<AuthBloc>().add(
        AuthUploadUserData(name: nameController.text.trim(), context: context));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(context, state.message);
                  }
                  if (state is AuthSucess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: image == null
                            ? const NetworkImage(
                                'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png')
                            : FileImage(image!),
                        radius: 64,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: pickImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            )),
                      )
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Enter your Name'),
                    ),
                  ),
                  IconButton(
                      onPressed: saveUserData, icon: const Icon(Icons.done))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
