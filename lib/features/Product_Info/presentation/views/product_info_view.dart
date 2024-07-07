import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saltandsugar/core/model/product_model.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/Product_Info/presentation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:saltandsugar/features/Product_Info/presentation/views/widgets/form_of_address.dart';
import 'package:saltandsugar/features/home/presentation/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_app_bar_profile.dart';

class ProductInfoView extends StatefulWidget {
  ProductInfoView({super.key, required this.productModel, required this.email});
  final ProductModel productModel;
  final String email;
  String? name;
  String? address;
  String? numberOfPhone;

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

int counterOfOrder = 1;

bool isLoading = false;
bool hasShownSnackbar = false;

class _ProductInfoViewState extends State<ProductInfoView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          if (!hasShownSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Order Done Successfully',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
              ),
            );

            setState(() {
              isLoading = false;
              hasShownSnackbar = true;
            });
          }
        } else if (state is AddOrderLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is AddOrderFailed) {
          if (!hasShownSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'An Error Occurred',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
              ),
            );

            setState(() {
              isLoading = false;
              hasShownSnackbar = true;
            });
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            CustomAppBarForProfile(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffFEF7FF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.productModel.image,
                    height: 200,
                    width: 200,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    widget.productModel.productName,
                    style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 25),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    '\$${widget.productModel.price}',
                    style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      setState(() {
                        if (counterOfOrder > 1) {
                          counterOfOrder--;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$counterOfOrder',
                    style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 22),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      setState(() {
                        counterOfOrder++;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 16,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child:
                                  SingleChildScrollView(child: FormOfAddress()),
                            );
                          });
                    },
                    child: Text(
                      'Add Another Address +',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
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
                    widget.numberOfPhone = documentSnapshot['mobileNum'];
                  });

                  BlocProvider.of<AddOrderCubit>(context).addOrder(
                      name: widget.name!,
                      address: AnotherAddress == null
                          ? widget.address!
                          : AnotherAddress!,
                      quantity: counterOfOrder,
                      mobileNum: widget.numberOfPhone!,
                      email: widget.email,
                      ProductName: widget.productModel.productName,
                      Price: r'$'
                              '${int.parse(widget.productModel.price) * counterOfOrder}'
                          .toString(),
                      image: widget.productModel.image);

                  // Reset snackbar flag
                  setState(() {
                    hasShownSnackbar = false;
                    counterOfOrder = 1;
                  });
                }
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Submit Order',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
