import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticketing_app/services/firebase.dart';
import 'package:ticketing_app/views/payment_page.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticketing App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTicket(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List ticket = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: ticket.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = ticket[index];
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String nama = data['nama'];
                  String tipe = data['tipe'];
                  String tanggal = data['tanggal'] ?? '';
                  String harga = data['harga'].toString();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tipe,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. $harga',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF2563EB),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(ticketData: data),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.shopping_cart_checkout,
                                  color: Colors.white,
                                ),
                                label: const Text('Beli', style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        },
      ),
    );
  }
}