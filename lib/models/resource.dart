class Resource {
  int _id;
  String _name;
  String _description;
  String _url;

  Resource.withoutId({String name, String description, String url}) {
    this._name = name;
    this._description = description;
    this._url = url;
  }
  Resource({int id, String name, String description, String url}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._url = url;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get description => _description;
  set description(String description) => _description = description;
  String get url => _url;
  set url(String url) => _url = url;

  Resource.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _description = json['Description'];
    _url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_id != null) {
      data['Id'] = _id;
    }
    data['Name'] = this._name;
    data['Description'] = this._description;
    data['Url'] = this._url;
    return data;
  }

  @override
  String toString() {
    return "Resource<id:${this.id}, name:${this.name}, description:${this.description}, url:${this.url}>";
  }
}
