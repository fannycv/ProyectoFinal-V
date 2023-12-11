import 'package:flutter/material.dart';

class Activity {
  String? action;
  String? activity;
  int? activityCode;
  String? activityType;
  int? activityTypeCode;

  Activity({
    this.action,
    this.activity,
    this.activityCode,
    this.activityType,
    this.activityTypeCode,
  });

  factory Activity.fromJson(
      {required String id, required Map<String, dynamic> json}) {
    return Activity(
      action: json['action'],
      activity: json['activity'],
      activityCode: json['activity_code'],
      activityType: json['activity_type'],
      activityTypeCode: json['activity_type_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'activity': activity,
      'activity_code': activityCode,
      'activity_type': activityType,
      'activity_type_code': activityTypeCode,
    };
  }

  IconData getIcon() {
    switch (action) {
      case 'pool':
        return Icons.pool;
      case 'directions_run':
        return Icons.directions_run;
      case 'directions_boat':
        return Icons.directions_boat;
      case 'local_see':
        return Icons.local_see;
      case 'local_activity':
        return Icons.local_activity;
      case 'local_dining':
        return Icons.local_dining;
      default:
        return Icons.usb;
    }
  }
}
