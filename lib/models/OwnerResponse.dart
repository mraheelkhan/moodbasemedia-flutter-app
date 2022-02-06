class OwnerResponse {
  int? status;
  String? message;
  List<OwnerData>? data;

  OwnerResponse({this.status, this.data, this.message});

  factory OwnerResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<OwnerData> dataList =
        list.map((data) => OwnerData.fromJson(data)).toList();
    return OwnerResponse(
        status: json['status'], data: dataList, message: json['message']);
  }
}

class OwnerData {
  int? id;
  String name;
  String phone;
  String address;

  OwnerData(
      {this.id,
      required this.name,
      required this.address,
      required this.phone});

  factory OwnerData.fromJson(Map<String, dynamic> json) {
    return OwnerData(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        phone: json['phone']);
  }
}

class OwnerCreateResponse {
  int? status;
  String? message;
  OwnerData? data;

  OwnerCreateResponse({this.status, this.data, this.message});

  factory OwnerCreateResponse.fromJson(Map<String, dynamic> json) {
    var dataList = OwnerData.fromJson(json['data']);
    return OwnerCreateResponse(
        status: json['status'], data: dataList, message: json['message']);
  }
}
