import 'package:contact_app/db/db_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  getAllContacts() async {
    contactList = await DBHelper.getAllContact();
    notifyListeners();
  }

  getAllFavoriteContact() async {
    contactList = await DBHelper.getAllFavoriteContact();
    notifyListeners();
  }

  Future<ContactModel> getContactByID(int id)=>DBHelper.getContactByID(id);

  Future<bool> insertContact(ContactModel contactModel) async {
    final rowID = await DBHelper.insertContact(contactModel);
    if (rowID > 0) {
      contactModel.id = rowID;
      contactList.add(contactModel);
      contactList.sort((c1, c2)=> c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }

  updateFavourite(int id, bool favorite, int index) async {
    final value = favorite?0:1;
    final rowId = await DBHelper.updateFavourite(id, value);

    if (rowId > 0) {
      contactList[index].favourite= !contactList[index].favourite;
      notifyListeners();
    }
  }

  deleteContact(int id) async {
    final deletedRodID= await DBHelper.deleteContact(id);
    if (deletedRodID>0) {
      contactList.removeWhere((element) => element.id==id);
      notifyListeners();

    }
  }
}
