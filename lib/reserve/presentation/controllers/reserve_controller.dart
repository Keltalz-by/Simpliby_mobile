import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReserveController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime(2021).obs;
  final Rx<TimeOfDay> _selectedTime = TimeOfDay.now().obs;

  String get date => DateFormat('yMMMEd').format(_selectedDate.value);
  String get time =>
      "${_selectedTime.value.hour}:${_selectedTime.value.minute.toString().padLeft(2, '0')} ${_selectedTime.value.period.name.toUpperCase()}";

  final RxInt _selectedRadio = 0.obs;
  int get selectedRadio => _selectedRadio.value;

  Future<void> selectDate(BuildContext context) async {
    /*  final DateTime? picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2015, 8),
        maxTime: DateTime(2101), onConfirm: (date) {
      _selectedDate.value = date;
    }, currentTime: DateTime.now(), locale: LocaleType.en);
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }*/
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime.value,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  changeSelectedRadio(int val) {
    _selectedRadio.value = val;
  }
}
