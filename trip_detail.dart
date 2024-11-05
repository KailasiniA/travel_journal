import 'package:flutter/material.dart';
import 'trip.dart';
import 'dart:io'; // Import the dart:io library for File

class TripDetail extends StatelessWidget {
  final Trip trip;

  const TripDetail({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trip.title)),
      body: SingleChildScrollView(
        // Make body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.file(File(trip.imagePath)), // Display the trip image
              const SizedBox(height: 20),
              Text(
                trip.description,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
