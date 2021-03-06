import 'package:bytebank_persist/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if(widget is FeatureItem) {
    return widget.name == name && widget.icon ==icon;
  }
  return false;
}