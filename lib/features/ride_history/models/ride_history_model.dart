// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RideHistoryModel {
    int id;
    String startLoc;
    String endLoc;
    String image;
    bool bookmarked;

    RideHistoryModel({
        required this.id,
        required this.startLoc,
        required this.endLoc,
        required this.image,
        required this.bookmarked,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startLoc': startLoc,
      'endLoc': endLoc,
      'image': image,
      'bookmarked': bookmarked,
    };
  }

   factory RideHistoryModel.fromMap(Map<String, dynamic> map) {
    return RideHistoryModel(
      id: map['id'] as int,
      startLoc: map['start_loc'] as String? ?? '',
      endLoc: map['end_loc'] as String? ?? '',
      image: map['image'] as String? ?? '',
      bookmarked: map['bookmarked'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RideHistoryModel.fromJson(String source) => RideHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
