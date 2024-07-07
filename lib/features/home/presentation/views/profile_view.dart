import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saltandsugar/features/home/presentation/manager/edit_user_data_cubit/edit_user_data_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_app_bar_profile.dart';

class ProfileView extends StatefulWidget {
  String? email;
  String? name;
  String? address;
  String? mobileNum;

  ProfileView({
    Key? key,
    required this.email,
    required this.name,
    required this.address,
    required this.mobileNum,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

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
          widget.name = documentSnapshot['name'];
          widget.address = documentSnapshot['address'];
          widget.mobileNum = documentSnapshot['mobileNum'];
        });
      } else {
        print("No document found for the provided query.");
      }
    } catch (e) {
      print("Failed to fetch user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EditUserDataCubit, EditUserDataState>(
        builder: (context, state) {
          if (state is EditUserDataSuccess) {
            fetchUserData(); // Fetch updated data after editing
          }
          return _buildProfileView();
        },
      ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        CustomAppBarForProfile(),
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text(
            'Profile Name',
            style: TextStyle(fontFamily: 'Gilroy-Bold'),
          ),
          subtitle: Text(widget.name!),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text(
            'Email',
            style: TextStyle(fontFamily: 'Gilroy-Bold'),
          ),
          subtitle: Text(widget.email!),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text(
            'Address',
            style: TextStyle(fontFamily: 'Gilroy-Bold'),
          ),
          subtitle: Text(widget.address!),
        ),
        ListTile(
          leading: Icon(Icons.sim_card),
          title: Text(
            'Mobile Number',
            style: TextStyle(fontFamily: 'Gilroy-Bold'),
          ),
          subtitle: Text(widget.mobileNum!),
        ),
      ],
    );
  }
}
