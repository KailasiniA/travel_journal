import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'trip.dart';
import 'dart:io';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imagePath;
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveTrip() {
    if (_titleController.text.isNotEmpty && _imagePath != null && _selectedDate != null) {
      final trip = Trip(
        title: _titleController.text,
        description: _descriptionController.text,
        imagePath: _imagePath!,
        date: _selectedDate!, // Save the selected date
      );
      Navigator.pop(context, trip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Trip Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            
            const SizedBox(height: 20),
            // Show the selected image
            _imagePath == null
                ? const Text('No image selected.')
                : Image.file(File(_imagePath!), height: 100),
            const SizedBox(height: 20),
            // Button for selecting an image
            ElevatedButton(
              onPressed: _pickImage, // Call the image picker method
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDate == null
                  ? 'No date selected.'
                  : 'Selected date: ${_selectedDate!.toLocal()}'.split(' ')[0], // Format date
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context), // Open date picker
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTrip,
              child: const Text('Save Trip'),
            ),
          ],
        ),
      ),
    );
  }
}
