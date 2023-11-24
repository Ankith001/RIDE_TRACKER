import 'package:flutter/material.dart';
import 'package:ride_tracker/features/ride_history/screens/ride_history_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RideTrackerApp());
}

class RideTrackerApp extends StatelessWidget {
  const RideTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: 'Ride Tracker',
        theme: ThemeData( 
           fontFamily: GoogleFonts.workSans ().fontFamily, 
          primarySwatch: Colors.blue,
        ),
        home: const RideHistoryScreen());
  }
}
