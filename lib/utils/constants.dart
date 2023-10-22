import 'package:caisseapp/screens/paid_screen.dart';
import 'package:caisseapp/screens/receive_screen.dart';
import 'package:caisseapp/screens/stats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
List<Widget> navWidget = [
  const ReceiveScreen(),
  const StatsScreen(),
  const PaidScreen()
];
