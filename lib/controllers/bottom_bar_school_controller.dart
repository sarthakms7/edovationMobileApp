import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

import '../firebase/firebase.dart';

class BottomBarSchoolController extends GetxController {
  var isLoading = false.obs;
  final banks = <String>[].obs;
  final appointments = <DocumentSnapshot>[].obs;
  final appointmentsAccepted = <DocumentSnapshot>[].obs;
  final appointmentsCompleted = <DocumentSnapshot>[].obs;
  final donations = <DocumentSnapshot>[].obs;
  final donationsAccepted = <DocumentSnapshot>[].obs;
  final donationsCompleted = <DocumentSnapshot>[].obs;
  final schools = <DocumentSnapshot>[].obs;
  var schoolIndex = 0.obs;
  var qrVerified = false.obs;

  @override
  void onInit() {
    isLoading(true);
    //appointments.bindStream(FirestoreDB().getAllAppointments());
    schools.bindStream(FirestoreDB().getAllSchools());

    isLoading(false);

    super.onInit();
  }
}
