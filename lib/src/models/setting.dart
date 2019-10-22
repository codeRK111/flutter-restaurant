class Setting {
  double defaultTax = 0;

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    defaultTax = double.parse(jsonMap['default_tax']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["default_tax"] = defaultTax;
    return map;
  }
}
