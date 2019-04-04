class Resource {
  int _id;
  String _name;
  String _description;
  String _url;
  String _addedDate;

  Resource.withoutId(
      {String name, String description, String url, String addedDate}) {
    this._name = name;
    this._description = description;
    this._url = url;
    this._addedDate = addedDate;
  }
  Resource(
      {int id, String name, String description, String url, String addedDate}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._url = url;
    this._addedDate = addedDate;
  }

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get url => _url;
  String get addedDate => _addedDate;

  Resource.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _description = json['Description'];
    _url = json['Url'];
    _addedDate = json['AddedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_id != null) {
      data['Id'] = _id;
    }
    data['Name'] = this._name;
    data['Description'] = this._description;
    data['Url'] = this._url;
    data['AddedDate'] = this._addedDate;
    return data;
  }

  @override
  String toString() {
    return "Resource<id:${this.id}, name:${this.name}, description:${this.description}, url:${this.url}, addedDate:${this.addedDate} >";
  }
}
