import 'dart:io';
import 'package:babylon_app/models/event.dart';
import 'package:babylon_app/services/event/eventExceptions.dart';
import 'package:babylon_app/services/event/eventService.dart';
import 'package:babylon_app/views/events/events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// This screen allows users to create a new event, complete with an image, name, date, time, short description, and detailed description.
class UpdateEventScreen extends StatefulWidget {
  final Event event;
  @override
  const UpdateEventScreen({Key? key, required this.event}) : super(key: key);
  _UpdateEventScreenState createState() => _UpdateEventScreenState(event);
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final Event event;
  _UpdateEventScreenState(this.event);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionShortController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  XFile? _image;
  String? _eventImgURL;
  final ImagePicker _picker = ImagePicker();
  String? _error = "";

  // Dispose controllers when the screen is removed
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionShortController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

    @override
  void initState(){
    super.initState();
    this._descriptionController.text = event.FullDescription!;
    this._descriptionShortController.text = event.ShortDescription!;
    this._nameController.text = event.Title!;
    this._placeController.text = event.Place!;
    this._image = null;
    this._eventImgURL = event.PictureURL!;
    this._selectedTime = TimeOfDay(hour: event.Date!.hour, minute: event.Date!.minute)!;
    this._selectedDate = event.Date!;

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
        title: Text('Update Event'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              labelText: '* Event Name',
            ),

            _buildTextField(
              controller: TextEditingController(text: _formatDateTime(_selectedDate, _selectedTime)),
              labelText: '* Date & Time',
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
                child: _image == null && _eventImgURL == null
                    ? Icon(Icons.camera_alt, color: Colors.grey)
                    : _image == null 
                      ? Image.network(_eventImgURL!, fit: BoxFit.cover) 
                      : Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8.0), // Add spacing between the elements
            _buildTextField(
              controller: _placeController,
              labelText: '* Location',
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
                    try {
                      EventException.validateUpdateOrCreateForm(
                        eventName: _nameController.text,
                        selectedDateTime: _selectedDate,
                        selectedTimeOfDay: _selectedTime,
                        place: _placeController.text);
                      await EventService.updateEvent(
                        eventUID: event.EventDocumentID,
                        eventName: _nameController.text,
                        image: _image == null ? null : File(_image!.path),
                        eventTimeStamp: Timestamp.fromDate(DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute)),
                        description: _descriptionShortController.text,
                        shortDescription: _descriptionController.text,
                        place: _placeController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EventsScreen()),
                      );
                    } catch (e) {
                      if(e is FirebaseAuthException)
                      setState(() {
                        _error = e.message; 
                      });
                    else
                      setState(() {
                        _error = e.toString(); 
                      });
                    }
                  },
                  child: Text('UPDATE'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8),
              child:
                Text(
                  _error!,
                  style: TextStyle(color: Colors.red),
              )
            ),
          ],
        ),
      ),
    );
  }
}