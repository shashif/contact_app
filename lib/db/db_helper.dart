import 'package:contact_app/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String creatTableContact = '''create table $tableContact(
  $tableContactColID integer primary key,
  $tableContactColNAME text,
  $tableContactColNUMBER text,
  $tableContactColEMAIL text,
  $tableContactColADDRESS text,
  $tableContactColDOB text,
  $tableContactColGENDER text,
  $tableContactColIMAGE text,
  $tableContactColCOMPANY text,
  $tableContactColDESIGNATION text,
  $tableContactColWEBSITE text,
  $tableContactColBloodGroup text,
  $tableContactColFAVOURITE integer)''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath, 'contact.db');
    return openDatabase(dbPath, version: 2, onCreate: (db, version) {
      db.execute(creatTableContact);
    }, onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion == 2) {
        db.execute(
            'alter table $tableContact add column $tableContactColBloodGroup text');
      }
    });
  }

  static Future<int> insertContact(ContactModel contactModel) async {
    final dbobject = await open();
    return dbobject.insert(tableContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContact() async {
    final dbobject = await open();
    // await dbobject.rawQuery('Select * from table_name');
    final maplList = await dbobject.query(tableContact,
        orderBy: '$tableContactColNAME asc'); //tableContact is a table name

    return List.generate(
        maplList.length, (index) => ContactModel.fromMap(maplList[index]));
  }

  static Future<List<ContactModel>> getAllFavoriteContact() async {
    final dbobject = await open();

    final maplList = await dbobject.rawQuery(
        "select * from $tableContact where $tableContactColFAVOURITE=1 order by $tableContactColNAME");
    // final maplList = await dbobject.query(tableContact, where: '$tableContactColFAVOURITE=?', whereArgs: [1],
    //     orderBy: '$tableContactColNAME asc'); //tableContact is a table name

    return List.generate(
        maplList.length, (index) => ContactModel.fromMap(maplList[index]));
  }

  static Future<int> updateFavourite(int id, int value) async {
    final dbobject = await open();
    return dbobject.update(tableContact, {tableContactColFAVOURITE: value},
        where: '$tableContactColID=?', whereArgs: [id]);
  }

  static Future<int> deleteContact(int id) async {
    final dbobject = await open();
    // return dbobject.rawQuery("delete from $tableContact where $tableContactColID=id");
    return dbobject
        .delete(tableContact, where: '$tableContactColID=?', whereArgs: [id]);
  }

  static Future<ContactModel> getContactByID(int id) async {
    final dbobject = await open();
    final maplList =
        // await dbobject.query(tableContact, where: '$tableContactColID=?' ,whereArgs: [id]); //tableContact is a table name
        await dbobject.rawQuery(
            "select * from $tableContact where $tableContactColID=id");
    return ContactModel.fromMap(maplList.first);
  }
}
