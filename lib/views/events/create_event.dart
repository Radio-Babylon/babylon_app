import 'dart:io';
import 'package:babylon_app/services/event/eventService.dart';
import 'package:babylon_app/views/events/events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// This screen allows users to create a new event, complete with an image, name, date, time, short description, and detailed description.
class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionShortController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Dispose controllers when the screen is removed
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionShortController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  // Function to pick date and time
  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      _selectedDate = date;
      _selectedTime = time;
    });
  }

  // Helper method to build text fields with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool readOnly = false,
    GestureTapCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        readOnly: readOnly,
        onTap: onTap,
      ),
    );
  }

  // Helper method to format date and time into a user-friendly string
  String _formatDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return 'Tap to select date & time';
    return '${MaterialLocalizations.of(context).formatFullDate(date)} at ${time.format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              labelText: 'Event Name',
            ),

            _buildTextField(
              controller: TextEditingController(text: _formatDateTime(_selectedDate, _selectedTime)),
              labelText: 'Date & Time',
              readOnly: true,
              onTap: () => _pickDateTime(context),
            ),

            SizedBox(height: 8.0), // Add spacing between the elements
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: _image == null
                    ? Icon(Icons.camera_alt, color: Colors.grey)
                    : Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8.0), // Add spacing between the elements
            _buildTextField(
              controller: _placeController,
              labelText: 'Location',
            ),
            _buildTextField(
              controller: _descriptionShortController,
              labelText: 'Short Description',
            ),
            _buildTextField(
              controller: _descriptionController,
              labelText: 'Event Description',
            ),


            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await EventService.createEvent(_nameController.text, File(_image!.path), Timestamp.fromDate(DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime!.hour,  _selectedTime!.minute)), _descriptionShortController.text, _descriptionController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventsScreen()),
                    );
                  },
                  child: Text('CREATE'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
