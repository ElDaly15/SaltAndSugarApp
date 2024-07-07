import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:saltandsugar/core/model/user_data.dart';
import 'package:saltandsugar/features/Login/presentation/views/data_user_view.dart';
import 'package:saltandsugar/features/Register/presentaion/views/register_view.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/home/presentation/views/home_view.dart';
import 'package:saltandsugar/features/splash/presentaion/views/splash_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  List<UserData> userData = [];
  bool isAsync = false;

  CollectionReference DataOfUser =
      FirebaseFirestore.instance.collection('dataOfUser');

  Future<void> loginUser() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        isAsync = true;
      });

      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);

        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Login Done Successfully',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
            ),
          );
          DataOfUser.snapshots().listen((data) {
            for (int i = 0; i < data.docs.length; i++) {
              userData.add(UserData.fromJson(data.docs[i].data()));
            }
          });

          QuerySnapshot querySnapshot =
              await DataOfUser.where('email', isEqualTo: email).limit(1).get();

          print(querySnapshot);

          if (querySnapshot.docs.isNotEmpty) {
            Get.to(HomeView(
              email: email!,
              userData: userData,
            ));
          } else {
            Get.to(DataUserView(
              userData: userData,
              dataOfUser: DataOfUser,
              email: email!,
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Verify Your Email Now, To Can Login',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
            ),
          );
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: Text(
                'No user found for that email.',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Wrong password provided for that user.',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
            ),
          );
        }
      }

      setState(() {
        isAsync = false;
      });
    }
  }

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
                      'Login to continue.',
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
                          'Forgot Password ?',
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
                        onPressed: loginUser,
                        child: Text(
                          'Login',
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
                          'New User ?',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(RegisterView(),
                                duration: Duration(milliseconds: 250),
                                transition: Transition.fade);
                          },
                          child: Text(
                            'Register',
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
