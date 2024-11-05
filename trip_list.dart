import 'package:flutter/material.dart';
import 'add_trip.dart';
import 'trip.dart';
import 'trip_detail.dart';
import 'dart:io';

class TripList extends StatefulWidget {
  const TripList({super.key});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Trip> trips = [];

  void _addTrip(Trip trip) {
    setState(() {
      trips.add(trip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Journal')),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(File(trips[index].imagePath), width: 50, height: 50, fit: BoxFit.cover),
            title: Text(trips[index].title),
            subtitle: Text(trips[index].description),
            trailing: Text(trips[index].date.toLocal().toString().split(' ')[0]), // Show the date here
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripDetail(trip: trips[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTrip = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTrip()),
          );
          if (newTrip != null) {
            _addTrip(newTrip);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
