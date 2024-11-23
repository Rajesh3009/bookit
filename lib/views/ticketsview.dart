import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  // Extract stream to a separate method for better readability
  Stream<QuerySnapshot> _getTicketsStream() {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  // Extract ticket card to a separate widget
  Widget _buildTicketCard(BuildContext context, Map<String, dynamic> ticket) {
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.confirmation_number,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          ticket['movie'] ?? 'No Title',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          'Date: ${ticket['date']}\nTime: ${ticket['time']}\nSeats: ${ticket['seats']}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle ticket tap
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'My Tickets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getTicketsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching tickets'));
                }

                final tickets = snapshot.data?.docs ?? [];

                if (tickets.isEmpty) {
                  return const Center(child: Text('No tickets found'));
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket =
                        tickets[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildTicketCard(context, ticket),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
