import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _image;
  String? _name;
  int? _age;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _submitProfile() {
    setState(() {
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _buildProfilePicture(),
            SizedBox(height: 20),
            _buildUploadButton(),
            SizedBox(height: 20),
            _buildNameTextField(),
            SizedBox(height: 20),
            _buildAgeTextField(),
            SizedBox(height: 20),
            _buildSubmitButton(),
            SizedBox(height: 20),
            _buildDisplayWidgets(),

          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
  return Center(
    child: GestureDetector(
      child: _image != null
          ? CircleAvatar(
              backgroundImage: FileImage(_image!),
              radius: 50,

              child: Text(
                '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : CircleAvatar(
              child: Icon(Icons.person, size: 50,),
              radius: 30,
              backgroundColor: Colors.grey,
            ),
    ),
  );
}
Widget _buildUploadButton() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 100),
    child: ElevatedButton(
      onPressed: _pickImage,
      style: ElevatedButton.styleFrom(
         primary: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        'Upload Image',
        style: TextStyle(
          fontSize: 18,
          color: Colors.yellow, 
        ),
      ),
    ),
  );
}



  Widget _buildNameTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      controller: _nameController,
      style: TextStyle(
        fontSize: 18, 
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.grey, 
          fontSize: 16, 
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10), 
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow), 
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

Widget _buildAgeTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      controller: _ageController,
        keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black, 
      ),
      decoration: InputDecoration(
        labelText: 'Age',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16, 
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), 
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), 
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _submitProfile,
        child: Text('Submit'),
      ),
    );
  }

  Widget _buildDisplayWidgets() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (_name != null) Text(
        'Name: $_name',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          decoration: TextDecoration.overline,
        ),
      ),
      if (_age != null) Text(
        'Age: $_age',
        style: TextStyle(
          fontSize: 18,
           fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.grey,
           decoration: TextDecoration.underline,
        ),
      ),
    ],
  );
}
}