import 'package:contact_app/pages/contact_details.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/provider/contactProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Consumer<ContactProvider>(
          builder: (context, provider, _) => BottomNavigationBar(
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });

              if (selectedIndex == 0) {
                provider.getAllContacts();
              }

              else if (selectedIndex == 1) {
                provider.getAllFavoriteContact();
              }
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Favorites'),
            ],
          ),
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            return Dismissible(
              key: ValueKey(contact.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: _showConfirmationDialoge,
              onDismissed: (direction) {
                provider.deleteContact(contact.id!);
              },
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                color: Colors.grey,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  size: 40,
                ),
              ),
              child: ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.number),
                trailing: IconButton(
                  icon: Icon(contact.favourite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    provider.updateFavourite(
                        contact.id!, contact.favourite, index);
                  },
                ),
                onTap: () => Navigator.pushNamed(
                    context, ContactDetails.routeName,
                    arguments: contact.id),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: const Icon(Icons.add),
        tooltip: "Add new Contact",
      ),
    );
  }

  Future<bool?> _showConfirmationDialoge(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete Contac!!"),
              content: Text("Are you sure to delete this contact?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("No")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Yes")),
              ],
            ));
  }
}
