import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Constants{
  static const Color augmentalColor = const Color(0xFF103B67);
  static String displayName = new GoogleSignIn().currentUser.displayName;

}