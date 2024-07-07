import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/home/presentation/manager/edit_user_data_cubit/edit_user_data_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_app_bar_profile.dart';

class UpdateData extends StatefulWidget {
  UpdateData(
      {super.key,
      required this.email,
      required this.LastName,
      required this.LastAddress,
      required this.LastNumber});
  final String email;
  final String LastName;
  final String LastAddress;
  final String LastNumber;

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  String? name;

  String? address;

  String? mobile;

  final formKeyUpdate = GlobalKey<FormState>();
  AutovalidateMode autovalidateModeUpdate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EditUserDataCubit, EditUserDataState>(
        listener: (context, state) {
          if (state is EditUserDataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Edit Done Successfuly',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
              ),
            );
          } else if (state is EditUserDataFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Edit Failed , Try Again',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: autovalidateModeUpdate,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CustomAppBarForProfile(),
                CustomTextField(
                  textInputType: TextInputType.name,
                  obscure: false,
                  mainText: 'Edit Name',
                  onChange: (value) {
                    name = value;
                  },
                ),
                CustomTextField(
                  textInputType: TextInputType.name,
                  obscure: false,
                  mainText: 'Edit Address',
                  onChange: (value) {
                    address = value;
                  },
                ),
                CustomTextField(
                  textInputType: TextInputType.number,
                  obscure: false,
                  mainText: 'Edit Mobile Number',
                  onChange: (value) {
                    mobile = value;
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(50, 40),
                    ),
                    onPressed: () {
                      BlocProvider.of<EditUserDataCubit>(context).editUserData(
                          email: widget.email,
                          name: name == null ? widget.LastName : name!,
                          address:
                              address == null ? widget.LastAddress : address!,
                          numMobile:
                              mobile == null ? widget.LastNumber : mobile!);
                    },
                    child: Text(
                      'Confirm Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy-Bold',
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
