import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourbuddy/app/models/activity_model.dart';

class ActivityProvider extends ChangeNotifier {
  ActivityProvider() {
    getActivities();
  }

  bool isLoading = false;
  List<Activity> activities = [];

  void update() {}

  Future<void> getActivities() async {
    enebledLoading();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('activities').get();

      activities = querySnapshot.docs
          .map((doc) => Activity.fromJson(
                id: doc.id,
                json: doc.data() as Map<String, dynamic>,
              ))
          .toList();

      notifyListeners();
    } catch (_) {}
    disabledLoading();
  }

  enebledLoading() {
    isLoading = true;
    notifyListeners();
  }

  disabledLoading() {
    isLoading = false;
    notifyListeners();
  }
}
