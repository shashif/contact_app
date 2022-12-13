const String tableContact = 'tbl_contact';
const String tableContactColID = 'id';
const String tableContactColNAME = 'name';
const String tableContactColNUMBER = 'number';
const String tableContactColEMAIL = 'email';
const String tableContactColADDRESS = 'address';
const String tableContactColDOB = 'dob';
const String tableContactColGENDER = 'gender';
const String tableContactColIMAGE = 'image';
const String tableContactColCOMPANY = 'company';
const String tableContactColDESIGNATION = 'designation';
const String tableContactColWEBSITE = 'website';
const String tableContactColFAVOURITE = 'favourite';
const String tableContactColBloodGroup = 'blood_group';

class ContactModel {
  int? id;
  String name;
  String number;
  String? email;
  String? address;
  String? dob;
  String? gender;
  String? image;
  String? company;
  String? designation;
  String? website;
  bool favourite;
  String? blood_group;

  ContactModel(
      {this.id,
      required this.name,
      required this.number,
      this.email,
      this.address,
      this.dob,
      this.gender,
      this.image,
      this.company,
      this.designation,
      this.website,
      this.favourite = false,
      this.blood_group});

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, number: $number, email: $email, address: $address, dob: $dob, gender: $gender, image: $image, company: $company, designation: $designation, website: $website, favourite: $favourite, blood_group: $blood_group}';
  }

  //for create
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableContactColNAME: name,
      tableContactColNUMBER: number,
      tableContactColEMAIL: email,
      tableContactColADDRESS: address,
      tableContactColDOB: dob,
      tableContactColGENDER: gender,
      tableContactColIMAGE: image,
      tableContactColCOMPANY: company,
      tableContactColDESIGNATION: designation,
      tableContactColWEBSITE: website,
      tableContactColFAVOURITE: favourite ? 1 : 0,
      tableContactColBloodGroup: blood_group,
    };

    if (id != null) {
      map[tableContactColID] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map[tableContactColID],
        name: map[tableContactColNAME],
        number: map[tableContactColNUMBER],
        email: map[tableContactColEMAIL],
        address: map[tableContactColADDRESS],
        dob: map[tableContactColDOB],
        gender: map[tableContactColGENDER],
        image: map[tableContactColIMAGE],
        company: map[tableContactColCOMPANY],
        designation: map[tableContactColDESIGNATION],
        website: map[tableContactColWEBSITE],
        favourite: map[tableContactColFAVOURITE] == 1 ? true : false,
        blood_group: map[tableContactColBloodGroup],
      );
}
