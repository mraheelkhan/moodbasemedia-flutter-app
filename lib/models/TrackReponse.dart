class TrackResponse {
  // int? status;
  // String? message;
  List<TrackData>? data;

  TrackResponse({this.data});

  factory TrackResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TrackData> dataList =
        list.map((data) => TrackData.fromJson(data)).toList();
    return TrackResponse(data: dataList);
  }
}

class TrackData {
  int? id;
  String url;
  String title;

  TrackData({this.id, required this.url, required this.title});

  factory TrackData.fromJson(Map<String, dynamic> json) {
    return TrackData(id: json['id'], url: json['url'], title: json['title']);
  }
}
