import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saltandsugar/core/model/user_data.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/Horizantal_divider.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_drawer.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/grid_view_builder.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/bottom_sheet_item.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key, required this.userData, required this.email});
  final List<UserData> userData;
  final String email;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool check = false;

  @override
  void initState() {
    super.initState();
    getDataAdmin();
  }

  getDataAdmin() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('admin', isEqualTo: widget.email)
        .limit(1)
        .get();

    setState(() {
      check = querySnapshot.docs.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, conts) {
      return Scaffold(
        body: Builder(
          builder: (context) => Column(
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: CustomAppBar()),
                ],
              ),
              CustomHortizantalDivider(),
              const SizedBox(height: 15),
              Expanded(
                child: GridViewBuilderItem(
                  email: widget.email,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        drawer: CustomDrawer(
          email: widget.email,
          usersData: widget.userData,
        ),
        floatingActionButton: check
            ? FloatingActionButton(
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomSheetItem();
                    },
                  );
                },
              )
            : null,
      );
    });
  }
}
