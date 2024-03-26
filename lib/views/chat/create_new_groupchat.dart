import "dart:io";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class CreateNewGroupChat extends StatefulWidget {
  const CreateNewGroupChat({super.key});

  @override
  _CreateNewGroupChatState createState() => _CreateNewGroupChatState();
}

class _CreateNewGroupChatState extends State<CreateNewGroupChat> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController = TextEditingController();
  File? _groupImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _groupImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Group Chat"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _groupImage != null ? FileImage(_groupImage!) : AssetImage("assets/group_placeholder.png") as ImageProvider,
                child: _groupImage == null ? Icon(Icons.camera_alt, color: Colors.white.withOpacity(0.7), size: 40) : null,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: _pickImage,
                  child: Text("Select a Photo", style: TextStyle(fontSize: 18, color: Colors.green)),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: "Group Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: Icon(Icons.group),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _groupDescriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Add People",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.person_add),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 40, color: Colors.green),
                    onPressed: () {
                      // Logic to add the searched person to the group
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Logic to create the group chat
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text("Create", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
