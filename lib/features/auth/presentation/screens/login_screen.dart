import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/core/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/core/utils/show_snackbar.dart';
import 'package:whatsapp_clone/core/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  Country? _country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void signIn() {
    String phoneNumber = phoneController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      phoneNumber =
          '+${_country!.phoneCode} ${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
      print(phoneNumber);
      context
          .read<AuthBloc>()
          .add(AuthLogin(context: context, phoneNumber: phoneNumber));
    } else {
      showSnackBar(context, 'Enter All the Fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Enter Your Phone Number'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'WhatsApp will need to verify your phone number',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            setState(() {
                              _country = country;
                            });
                          },
                        );
                      },
                      child: const Text(
                        'Pick country',
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                  Row(
                    children: [
                      if (_country != null) Text('+${_country!.phoneCode}'),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          maxLines: 1,
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'phone number',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                  ),
                  SizedBox(
                      width: size.width * 0.2,
                      child: CustomButton(buttonText: 'Next', onTap: signIn))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
