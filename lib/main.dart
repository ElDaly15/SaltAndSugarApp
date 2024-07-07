import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/features/Product_Info/presentation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:saltandsugar/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:saltandsugar/features/home/presentation/manager/edit_user_data_cubit/edit_user_data_cubit.dart';
import 'package:saltandsugar/features/home/presentation/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:saltandsugar/features/splash/presentaion/views/splash_view.dart';
import 'package:saltandsugar/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "resturant",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SaltAndSugarApp());
}

class SaltAndSugarApp extends StatelessWidget {
  const SaltAndSugarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddProductCubit()..displayProduct(),
        ),
        BlocProvider(
          create: (context) => EditUserDataCubit(),
        ),
        BlocProvider(
          create: (context) => AddOrderCubit(),
        ),
        BlocProvider(
          create: (context) => GetOrdersCubit(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: 'Gilroy'),
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
