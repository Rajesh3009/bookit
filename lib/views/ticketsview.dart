import 'package:flutter/material.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Tickets',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // TODO: Replace with actual tickets count
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_number),
                    title: Text('Ticket #${index + 1}'),
                    subtitle: const Text('Movie Name - Date & Time'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Implement ticket detail view
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
