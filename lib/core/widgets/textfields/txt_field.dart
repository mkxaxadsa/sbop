import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../utils.dart';

class TxtField extends StatefulWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    this.number = false,
    this.date = false,
    this.length = 20,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool number;
  final bool date;
  final int length;
  final void Function() onChanged;

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  void onDateTimeChanged(DateTime date) {
    setState(() {
      widget.controller.text = formatDateTime(date);
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.main40,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: widget.controller,
        readOnly: widget.date ? true : false,
        textAlign: TextAlign.center,
        keyboardType: widget.number ? TextInputType.number : null,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.length),
          if (widget.number) FilteringTextInputFormatter.digitsOnly,
        ],
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontFamily: Fonts.medium,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: SvgPicture.asset('assets/suffix.svg'),
              ),
            ],
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.white40,
            fontSize: 20,
            fontFamily: Fonts.medium,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          widget.onChanged();
        },
        onTap: () async {
          if (widget.date) {
            await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      onDateTimeChanged: onDateTimeChanged,
                      initialDateTime:
                          convertToDateTime(widget.controller.text),
                      mode: CupertinoDatePickerMode.date,
                      minimumYear: 1970,
                      maximumYear: DateTime.now().year,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// 1
//  date_picker_plus: ^4.1.0
// 2
//  readOnly: true,
// 3
// onTap: () async {
//     final date = await showDatePickerDialog(
//         context: context,
//         leadingDateTextStyle: const TextStyle(
//           color: AppColors.purple1,
//           fontWeight: FontWeight.w700,
//           fontFamily: 'InterB',
//         ),
//         enabledCellsTextStyle: const TextStyle(
//           color: AppColors.black,
//         ),
//         currentDateTextStyle: const TextStyle(
//           color: AppColors.white,
//         ),
//         currentDateDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: const Color(0xffFB41FF),
//           // border: Border.all(color: const Color(0xffFB41FF)),
//         ),
//         disabledCellsTextStyle: const TextStyle(
//           color: AppColors.black,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           fontFamily: 'InterM',
//         ),
//         daysOfTheWeekTextStyle: const TextStyle(
//           color: Color(0xff3d3d40),
//           fontSize: 12,
//           fontWeight: FontWeight.w600,
//           fontFamily: 'InterM',
//         ),
//         splashColor: AppColors.pink1,
//         highlightColor: AppColors.pink1,
//         slidersColor: AppColors.purple1,
//         currentDate: controller.text.isEmpty
//             ? DateTime.now()
//             : convertToDateTime(controller.text),
//         minDate: DateTime(2020, 1, 1),
//         maxDate: DateTime(2030, 1, 1),
//         padding: EdgeInsets.zero,
//         contentPadding: const EdgeInsets.all(24),
//         height: 318,
//     );
//     if (date != null) {
//         onDate(formatDateTime(date));
//     }
// },
