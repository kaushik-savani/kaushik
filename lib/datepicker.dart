import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextFormField(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1992),
            lastDate: DateTime(2050),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                      primary: Colors.red,
                      onPrimary: Colors.white,//selected round text color
                      onSurface: Colors.white,
                    // <-- SEE HERE
                  ),
                  dialogBackgroundColor: Colors.black54,

                ),
                child: child!,
              );
            },
          );
        },
      )),
    );
  }
}
