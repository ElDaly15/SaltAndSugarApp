import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/Login/presentation/views/Login_view.dart';
import 'package:saltandsugar/features/home/presentation/views/home_view.dart';
import 'package:saltandsugar/features/splash/presentaion/views/splash_view.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  bool isAsync = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: Colors.black,
      ),
      inAsyncCall: isAsync,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(52),
                  bottomLeft: Radius.circular(52),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 23),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 42,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontFamily: 'Gilroy-Bold',
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'Register to continue.',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      textInputType: TextInputType.name,
                      obscure: false,
                      mainText: 'Email',
                      onChange: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      textInputType: TextInputType.name,
                      obscure: true,
                      mainText: 'Password',
                      onChange: (value) {
                        password = value;
                      },
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Contact Us If You Have Problem',
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(210, 50),
                        ),
                        onPressed: () async {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            setState(() {
                              isAsync = true;
                            });

                            try {
                              UserCredential credential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Register Done Successfully. Please verify your email.',
                                    style: TextStyle(fontFamily: 'Gilroy'),
                                  ),
                                ),
                              );

                              setState(() {
                                isAsync = false;
                              });

                              await FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();

                              bool emailVerified = false;
                              while (!emailVerified) {
                                await Future.delayed(Duration(seconds: 3));
                                await FirebaseAuth.instance.currentUser!
                                    .reload();
                                emailVerified = FirebaseAuth
                                    .instance.currentUser!.emailVerified;
                              }

                              if (emailVerified) {
                                Get.offAll(LoginView());
                              } else {
                                Get.offAll(LoginView());
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'The password provided is too weak.',
                                      style: TextStyle(fontFamily: 'Gilroy'),
                                    ),
                                  ),
                                );
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black,
                                    behavior: SnackBarBehavior.floating,
                                    content: FirebaseAuth
                                            .instance.currentUser!.emailVerified
                                        ? Text(
                                            'The account already exists for that email.',
                                            style:
                                                TextStyle(fontFamily: 'Gilroy'),
                                          )
                                        : Text(
                                            'The account already exists for that email , Verify Email Now To Can Login.',
                                            style:
                                                TextStyle(fontFamily: 'Gilroy'),
                                          ),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy-Bold',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have account ?',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'Gilroy'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
