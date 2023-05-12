import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firebase service page to connect app to some specific firebase services
class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //final uid1 = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<DocumentSnapshot>> getAllSchools() {
    return _firebaseFirestore
        .collection('schools')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllAppointments(uid1) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid1)
        .collection('appointments')
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllAppointmentsCompleted(uid1) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid1)
        .collection('appointments')
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllDonations(uid1) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid1)
        .collection('donation_requests')
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllDonationsCompleted(uid1) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid1)
        .collection('donation_requests')
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllAppointmentRequests(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('appointment_requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllAppointmentRequestsAccepted(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('appointment_requests')
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllAppointmentRequestsCompleted(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('appointment_requests')
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllDonationRequests(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('donation_requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllDonationRequestsAccepted(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('donation_requests')
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }

  Stream<List<DocumentSnapshot>> getAllDonationRequestsCompleted(schoolId) {
    return _firebaseFirestore
        .collection('schools')
        .doc(schoolId)
        .collection('donation_requests')
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc).toList());
  }
}
