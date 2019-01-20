class Resource {
  int _id;
  String _name;
  String _description;
  String _url;
  Resource(this._name, this._description, this._url);
  Resource.withId(this._id, this._name, this._description, this._url);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get url => _url;

  set name(String value) {
    if (value.length >= 3) {
      _name = value;
    }
  }

  set description(String value) {
    if (value.length >= 10) {
      _description = value;
    }
  }

  set url(String value) {
    if (value.length >= 10) {
      _url = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    map["url"] = _url;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Resource.fromObject(dynamic o) {
    this._id = o["Id"];
    this._name = o["Name"];
    this._description = o["Description"];
    this._url = o["Url"];
  }

  /*
  Resource.fromJson(Map json) {
    this.name = json['name'];
    this.description = json['description'];
    this.host = json['host'];
    this.port = json['port'];
  }

  Map toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "host": this.host,
      "port": this.port,
    };
  }
  */
}
