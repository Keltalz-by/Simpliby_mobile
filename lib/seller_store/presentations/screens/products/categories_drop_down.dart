import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/seller_store/data/models/category.dart';

class CustomDropdown extends StatefulWidget {
  final List<Category> items;
  final Category value;
  final String hintText;
  final void Function(Category?) onChanged;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.hintText,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 59.h,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: blueColor, width: 2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButton<Category>(
        value: widget.value,
        elevation: 0,
        icon: Container(),
        underline: Container(),
        items: widget.items.map((Category item) {
          return DropdownMenuItem<Category>(
            value: item,
            child: Text(item.categoryName),
          );
        }).toList(),
        onChanged: widget.onChanged,
        hint: Text(widget.hintText),
      ),
    );
  }
}
