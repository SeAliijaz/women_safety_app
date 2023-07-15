class ContactModel {
  int? _id;
  String? _number;
  String? _name;

  ContactModel(this._number, this._name);
  ContactModel.withId(this._id, this._number, this._name);

  //getters
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  //setters
  set number(String newNumber) => _number = newNumber;
  set name(String newName) => _name = newName;

  //convert a Contact object to a Map object
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = _id;
    map['number'] = _number;
    map['name'] = _name;

    return map;
  }

  //Extract a Contact Object from a Map object
  ContactModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _number = map['number'];
    _name = map['name'];
  }
}
