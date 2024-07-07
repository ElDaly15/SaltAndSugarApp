import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_user_data_state.dart';

class EditUserDataCubit extends Cubit<EditUserDataState> {
  EditUserDataCubit() : super(EditUserDataInitial());

  editUserData(
      {required String email,
      required String name,
      required String address,
      required String numMobile}) async {
    try {
      emit(EditUserDataLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('dataOfUser')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        DocumentReference docRef = documentSnapshot.reference;

        await docRef
            .update({'name': name, 'address': address, 'mobileNum': numMobile})
            .then((_) => print("Document Updated"))
            .catchError((error) => print("Failed to update document: $error"));
      } else {
        print("No document found for the provided query.");
      }

      emit(EditUserDataSuccess());
    } catch (e) {
      emit(EditUserDataFailed());
    }
  }
}
