import 'dart:io';

import 'package:contact_app/db/db_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/provider/contactProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final numbController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  // final dobController = TextEditingController();
  // final gendarController = TextEditingController();
  // final imageController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();

  String? _dob;
  String? _gendarGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    numbController.dispose();
    emailController.dispose();
    addressController.dispose();
    // dobController.dispose();
    // gendarController.dispose();
    // imageController.dispose();
    companyController.dispose();
    designationController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact Page"),
        actions: [
          IconButton(onPressed: _saveContactInfo, icon: Icon(Icons.done))
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            //nameController
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name:",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),

            //numbController
            TextFormField(
              controller: numbController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number:",
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),

            //emailController
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email:",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),

            //addressController
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Address:",
                prefixIcon: Icon(Icons.location_city_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ), //addressController
            SizedBox(
              height: 10,
            ),

            //dobController
            // TextFormField(
            //   controller: dobController,
            //   keyboardType: TextInputType.datetime,
            //   decoration: InputDecoration(
            //     labelText: "Date of Birth:",
            //     prefixIcon: Icon(Icons.date_range),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "This field must not be empty";
            //     }
            //     // if (value.length > 20) {
            //     //   return " Name must be in 20 chareter ";
            //     // }
            //     else {
            //       return null;
            //     }
            //   },
            // ),

            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectedDate,
                      child: Text("Select Date of Birth")),
                  Text(_dob == null ? "No date selected" : _dob!),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //gendarController
            // TextFormField(
            //   controller: gendarController,
            //   decoration: InputDecoration(
            //     labelText: "Gendar:",
            //     prefixIcon: Icon(Icons.man),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "This field must not be empty";
            //     }
            //     // if (value.length > 20) {
            //     //   return " Name must be in 20 chareter ";
            //     // }
            //     else {
            //       return null;
            //     }
            //   },
            // ),

            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select Gendar"),
                  Radio<String>(
                      value: "Male",
                      groupValue: _gendarGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _gendarGroupValue = value;
                        });
                      }),
                  Text("Male"),
                  Radio<String>(
                      value: "Female",
                      groupValue: _gendarGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _gendarGroupValue = value;
                        });
                      }),
                  Text("Female"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //imageController
            // TextFormField(
            //   controller: imageController,
            //   decoration: InputDecoration(
            //     labelText: "Image:",
            //     prefixIcon: Icon(Icons.photo),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "This field must not be empty";
            //     }
            //     // if (value.length > 20) {
            //     //   return " Name must be in 20 chareter ";
            //     // }
            //     else {
            //       return null;
            //     }
            //   },
            // ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: _imagePath == null
                        ? Image.asset(
                            'images/personimage.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          )
                        : Image.file(File(_imagePath!),
                            height: 100, width: 100, fit: BoxFit.contain),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _imageSource = ImageSource.camera;
                            _getImage();
                          },
                          child: Text("Camera")),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _imageSource = ImageSource.gallery;
                            _getImage();
                          },
                          child: Text("Gallery")),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //companyController
            TextFormField(
              controller: companyController,
              decoration: InputDecoration(
                labelText: "Company name:",
                prefixIcon: Icon(Icons.circle),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),

            //designationController
            TextFormField(
              controller: designationController,
              decoration: InputDecoration(
                labelText: "Designation:",
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),

            //websiteController
            TextFormField(
              controller: websiteController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: "Website:",
                prefixIcon: Icon(Icons.web),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
                // if (value.length > 20) {
                //   return " Name must be in 20 chareter ";
                // }
                else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _saveContactInfo() async {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: nameController.text,
        number: numbController.text,
        email: emailController.text,
        address: addressController.text,
        // dob: dobController.text,
        // gender: gendarController.text,
        // image: imageController.text,
        dob: _dob,
        gender: _gendarGroupValue,
        image: _imagePath,
        company: companyController.text,
        designation: designationController.text,
        website: websiteController.text,
      );
      print(contact.toString());
      // final rowID = await DBHelper.insertContact(contact);
      final status = await Provider.of<ContactProvider>(context, listen: false)
          .insertContact(contact);

      if (status) {

        Navigator.pop(context);
      } else {}
    }
  }

  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
      });
    }
  }
}
