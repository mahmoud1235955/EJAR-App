import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'icons_state.dart';

class IconsCubit extends Cubit<IconsState> {
  IconsCubit() : super(IconsInitial());
  Icon getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.car_rental_sharp, color: Colors.black);
      case 1:
        return Icon(Icons.real_estate_agent, color: Colors.black);
      case 2:
        return Icon(Icons.smartphone_sharp, color: Colors.black);
      case 3:
        return Icon(Icons.home_repair_service, color: Colors.black);
      default:
        return Icon(Icons.smart_toy_rounded, color: Colors.black);
    }
  }

  String getIconName(int index) {
    switch (index) {
      case 0:
        return "Cars";
      case 1:
        return "Real Estate";
      case 2:
        return "Smart Equipments";
      case 3:
        return "Home Repair";
      default:
        return "Smart Toys";
    }
  }
}
