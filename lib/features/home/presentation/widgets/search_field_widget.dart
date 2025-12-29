import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key, this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade300,
      elevation: 2,
      child: TextField(
        onChanged: onChanged,

        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: LocaleKeys.search.tr(),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
