import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/core/model/user_data.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/home/presentation/views/home_view.dart';

class DataUserView extends StatefulWidget {
  DataUserView(
      {super.key,
      required this.dataOfUser,
      required this.email,
      required this.userData});
  final CollectionReference dataOfUser;
  final String email;

  final List<UserData> userData;

  @override
  State<DataUserView> createState() => _DataUserViewState();
}

class _DataUserViewState extends State<DataUserView> {
  String? name;
  String? address;
  String? mobileNum;
  final formKeyData = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        autovalidateMode: autovalidateMode,
        key: formKeyData,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                  textInputType: TextInputType.name,
                  mainText: 'Name',
                  onChange: (value) {
                    name = value;
                  },
                  obscure: false,
                ),
                CustomTextField(
                  textInputType: TextInputType.name,
                  mainText: 'Address',
                  onChange: (value) {
                    address = value;
                  },
                  obscure: false,
                ),
                CustomTextField(
                  textInputType: TextInputType.number,
                  mainText: 'Mobile Number',
                  onChange: (value) {
                    mobileNum = value;
                  },
                  obscure: false,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(50, 40),
                  ),
                  onPressed: () async {
                    if (formKeyData.currentState != null &&
                        formKeyData.currentState!.validate()) {
                      await widget.dataOfUser.add({
                        'name': name,
                        'address': address,
                        'email': widget.email,
                        'mobileNum': mobileNum,
                      });
                      widget.dataOfUser.snapshots().listen((data) {
                        for (int i = 0; i < data.docs.length; i++) {
                          widget.userData
                              .add(UserData.fromJson(data.docs[i].data()));
                        }
                      });
                      Get.to(HomeView(
                        email: widget.email,
                        userData: widget.userData,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Data Confirmed Successfuly',
                            style: TextStyle(fontFamily: 'Gilroy'),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Error In data , Try Again',
                            style: TextStyle(fontFamily: 'Gilroy'),
                          ),
                        ),
                      );
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy-Bold',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
