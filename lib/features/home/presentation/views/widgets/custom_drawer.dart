import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/core/model/user_data.dart';
import 'package:saltandsugar/features/home/presentation/manager/edit_user_data_cubit/edit_user_data_cubit.dart';
import 'package:saltandsugar/features/home/presentation/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/order_view.dart';
import 'package:saltandsugar/features/home/presentation/views/profile_view.dart';
import 'package:saltandsugar/features/home/presentation/views/update_data.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.usersData, required this.email});
  final List<UserData> usersData;
  final String email;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? name;

  String? address;

  String? mobileNum;

  @override
  Widget build(BuildContext context) {
    void fetchUserData() async {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('dataOfUser')
            .where('email', isEqualTo: widget.email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          setState(() {
            name = documentSnapshot['name'];
          });
        } else {
          print("No document found for the provided query.");
        }
      } catch (e) {
        print("Failed to fetch user data: $e");
      }
    }

    for (int i = 0; i < widget.usersData.length; i++) {
      if (widget.usersData[i].email == widget.email) {
        name = widget.usersData[i].name;
        address = widget.usersData[i].address;
        mobileNum = widget.usersData[i].mobileNum;
      }
    }

    void initState() {
      BlocProvider.of<GetOrdersCubit>(context).getOrders(email: widget.email);
      super.initState();
      fetchUserData();
    }

    return Drawer(
      child: BlocBuilder<EditUserDataCubit, EditUserDataState>(
        builder: (context, state) {
          if (state is EditUserDataSuccess) {
            fetchUserData();
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(
                    name!,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(widget.email),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Get.to(ProfileView(
                    email: widget.email,
                    mobileNum: mobileNum!,
                    name: name!,
                    address: address!,
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' My Orders '),
                onTap: () {
                  Get.to(OrderView(
                    email: widget.email,
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () {
                  Get.to(UpdateData(
                    LastName: name!,
                    LastAddress: address!,
                    LastNumber: mobileNum!,
                    email: widget.email,
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
