
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reconnect/Views/color.dart';
import 'postlist.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  List<PostModel> allPosts = [];
  File? _selectedImage;
  File? pickedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateoflostController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<Map<String, String>> _countryCodes = [
    {"name": " Select Country Code", "code": ""},
    {"name": "+1 (US)", "code": "+1"},
    {"name": "+44 (UK)", "code": "+44"},
    {"name": "+49 (Germany)", "code": "+49"},
    {"name": "+61 (Australia)", "code": "+61"},
    {"name": "+86 (China)", "code": "+86"},
    {"name": "+91 (India)", "code": "+91"},
    {"name": "+81 (Japan)", "code": "+81"},
    {"name": "+7 (Russia)", "code": "+7"},
    {"name": "+971 (UAE)", "code": "+971"},
    {"name": "+90 (Turkey)", "code": "+90"},
    {"name": "+92 (Pakistan)", "code": "+92"},
    {"name": "+234 (Nigeria)", "code": "+234"},
    {"name": "+254 (Kenya)", "code": "+254"},
    {"name": "+20 (Egypt)", "code": "+20"},
  ];

  String _selectedCountryCode = "";

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  ////////////////////////////////////////////////////////

  Future<void> pickImage() async {
    final pickedImageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(pickedImageFile!.path);
    });
  }

//////////////////////////////////////////////////////////

  bool _isSubmitting = false;

void _startSubmitting() {
  setState(() {
    _isSubmitting = true;
  });
}

void _stopSubmitting() {
  setState(() {
    _isSubmitting = false;
  });
}

  void _submitPost() async {
    // Start submitting
    _startSubmitting();

    // Collect post data
    String name = _nameController.text;
    String dateoflost = _dateoflostController.text;
    String phone = _selectedCountryCode + _phoneController.text;
    String description = _descriptionController.text;

    if (name.isEmpty ||
        dateoflost.isEmpty ||
        phone.isEmpty ||
        _selectedImage == null ||
        description.isEmpty) {
      // Stop submitting if validation fails
      _stopSubmitting();
      return;
    }

    // Upload image to Firebase Storage and get download URL
    String imageUrl = await uploadImageToStorage(_selectedImage!);

    // Get the current date and time
    final now = DateTime.now();

    // Format the date and time
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm a');
    final formattedDate = dateFormat.format(now);
    final formattedTime = timeFormat.format(now);

    // Create a map of the post data
    Map<String, dynamic> postData = {
      'name': name,
      'dateoflost': dateoflost,
      'phone': phone,
      'description': description,
      'image_url': imageUrl,
      'datestamp': formattedDate,
      'timestamp': formattedTime,
    };

    try {
      // Add the post data to Firestore
      await FirebaseFirestore.instance.collection('posts').add(postData);

      // Reset input fields after posting
      setState(() {
        _selectedImage = null;
        _nameController.clear();
        _dateoflostController.text = '/ / /';
        _phoneController.clear();
        _descriptionController.clear();
      });

      // Stop submitting after successful submission
      _stopSubmitting();

      // Navigate to post list page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostListPage(posts: allPosts),
        ),
      );
    } catch (error) {
      // Handle the error
      print('Error submitting post: $error');
      // Stop submitting if an error occurs
      _stopSubmitting();
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      // Create reference to images collection in Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload image to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Wait until upload is complete and get download URL
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Return download URL for the image
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.primaryColor,
  
    body: Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePicker(),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
              ),
              SizedBox(height: 16.0),
              _buildDateField(
                controller: _dateoflostController,
                labelText: 'Date of Lost',
              ),
              SizedBox(height: 16.0),
              _buildPhoneNumberField(),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitPost,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
         if (_isSubmitting)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // Semi-transparent black color
              child: Center(
                child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(AppColors.secondaryColor), ), // Loader
              ),
            ),
          ),
      ],
    ),
  );
}

  Widget _buildImagePicker() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _getImage,
          child: Text('Choose Image'),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: _getImage,
          child: Container(
            height: 200,
            color: Colors.grey[200],
            child: _selectedImage != null
                ? Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
            )
                : Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Image.asset('assets/upload.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
  icon: Icon(Icons.calendar_today),
  onPressed: () async {
   final pickedDate = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime.now(),
  builder: (BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: AppColors.secondaryColor, // Change the primary color here
         
         
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: child!,
    );
  },
);
    if (pickedDate != null) {
      final formattedDate = DateFormat('d/M/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  },
),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          initialCountryCode: 'EG',
          onChanged: (phone) {
            _phoneController.text = phone.completeNumber;
          },
        ),
      ),
    ],
  );
}
}
