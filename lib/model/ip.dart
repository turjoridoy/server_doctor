class Ip {
  bool? status;
  String? address;

  Ip({this.status, this.address});

  Ip.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['address'] = this.address;
    return data;
  }


  static List<Ip> fromJsonList(jsonList) {
    return jsonList.map<Ip>((obj) => Ip.fromJson(obj)).toList();
  }
}