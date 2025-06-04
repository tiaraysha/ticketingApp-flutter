import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference ticket =
      FirebaseFirestore.instance.collection('tickets');

  Stream<QuerySnapshot> getTicket() {
    return ticket.snapshots();
  }

  Future<void> addTicket(String nama, String tipe, String harga) {
    return ticket.add({
      'nama': nama,
      'tipe': tipe,
      'harga': harga,
      'createdAt': Timestamp.now(),
    });
  }
}
