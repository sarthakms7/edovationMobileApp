import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

import '../firebase/firebase.dart';

class BottomBarUserController extends GetxController {
  var isLoading = false.obs;
  final banks = <String>[].obs;
  final appointments = <DocumentSnapshot>[].obs;
  final appointmentsCompleted = <DocumentSnapshot>[].obs;
  final donations = <DocumentSnapshot>[].obs;
  final donationsCompleted = <DocumentSnapshot>[].obs;
  final schools = <DocumentSnapshot>[].obs;
  var schoolIndex = 0.obs;

  @override
  void onInit() {
    isLoading(true);
    appointments.bindStream(FirestoreDB()
        .getAllAppointments(FirebaseAuth.instance.currentUser!.uid));
    appointmentsCompleted.bindStream(FirestoreDB()
        .getAllAppointmentsCompleted(FirebaseAuth.instance.currentUser!.uid));
    donations.bindStream(
        FirestoreDB().getAllDonations(FirebaseAuth.instance.currentUser!.uid));
    appointmentsCompleted.bindStream(FirestoreDB()
        .getAllDonationsCompleted(FirebaseAuth.instance.currentUser!.uid));
    schools.bindStream(FirestoreDB().getAllSchools());

    isLoading(false);

    super.onInit();
  }
}
