import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final String selectedCity;
  const LocationWidget({required this.selectedCity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      selectedCity,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
