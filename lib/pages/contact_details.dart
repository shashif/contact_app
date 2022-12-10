import 'dart:io';

import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/provider/contactProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  static const String routeName = '/contact_details';

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  late int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body: Center(
        child: Consumer<ContactProvider>(
          builder: (context, provider, _) => FutureBuilder<ContactModel>(
            future: provider.getContactByID(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final model = snapshot.data;
                return ListView(
                  children: [
                    Image.file(
                      File(model!.image!),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Text(model.name),
                    Text(model.number),
                    Text(model.email!),
                    Text(model.address!),
                    Text(model.dob!),
                    Text(model.gender!),
                    Text(model.company!),
                    Text(model.designation!),
                    Text(model.website!),

                  ],
                );
              }
              if (snapshot.hasError) {
                return const Text('Failed to fetch data');
              }
              return const CircularProgressIndicator();
            },
          ), // _ means child
        ),
      ),
    );
  }
}
