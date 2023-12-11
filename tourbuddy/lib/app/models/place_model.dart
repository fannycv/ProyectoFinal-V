import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String? typeCategory;
  List<int>? activities;
  String? file;
  String? name;
  String? state;
  String? description;
  String? department;
  String? particularities;
  String? province;
  List<String>? gallery;
  String? subTypeCategory;
  String? district;
  int? code;
  String? category;
  GeoPoint? location;

  Place({
    this.typeCategory,
    this.activities,
    this.file,
    this.location,
    this.name,
    this.state,
    this.description,
    this.department,
    this.particularities,
    this.province,
    this.gallery,
    this.subTypeCategory,
    this.district,
    this.code,
    this.category,
  });

  factory Place.fromJson(
      {required String id, required Map<String, dynamic> json}) {
    GeoPoint locationTemp = json['location'] as GeoPoint;

    return Place(
      typeCategory: json['type_category'],
      activities: json['activities'] != null
          ? (json['activities'] as List<dynamic>).cast<int>()
          : [],
      file: json['file'],
      location: locationTemp,
      name: json['name'],
      state: json['state'],
      description: json['description'],
      department: json['department'],
      particularities: json['particularities'],
      province: json['province'],
      gallery: json['gallery'] != null
          ? (json['gallery'] as List<dynamic>).cast<String>()
          : null,
      subTypeCategory: json['sub_type_category'],
      district: json['district'],
      code: json['code'],
      category: json['category'],
    );
  }
}
