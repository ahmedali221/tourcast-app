import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final String ticketId;

  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Ticket #$ticketId')),
    );
  }
}
