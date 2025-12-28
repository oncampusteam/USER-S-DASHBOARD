import 'package:flutter/material.dart';

class ViewRoomReceit extends StatefulWidget {
  const ViewRoomReceit({super.key});

  @override
  State<ViewRoomReceit> createState() => _ViewRoomReceitState();
}

double _height = 0;

class _ViewRoomReceitState extends State<ViewRoomReceit> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: _height, duration: const Duration(milliseconds: 400,),);
  }
}
