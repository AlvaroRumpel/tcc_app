import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:play_workout/utils/custom_colors.dart';

class StandartTextfield extends StatelessWidget {
  String labelText;
  bool? obscure;
  Function validator;
  String errorText;
  TextEditingController controller;
  bool spaced = false;
  TextInputType? keyboardType;
  String? hintText;
  bool date = false;
  bool textBox = false;
  bool fit;
  int? maxLength;
  Function(String)? onChanged;
  StandartTextfield({
    Key? key,
    required this.labelText,
    this.obscure = false,
    required this.validator,
    required this.errorText,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.spaced = false,
    this.date = false,
    this.hintText,
    this.textBox = false,
    this.fit = false,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: fit
          ? const EdgeInsets.all(0)
          : spaced
              ? const EdgeInsets.only(top: 8, bottom: 24, left: 16, right: 16.0)
              : const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: date
            ? DateTimePicker(
                style: GoogleFonts.poppins(
                  color: CustomColors.secondaryColor,
                  fontSize: 16,
                ),
                calendarTitle: 'Selecione uma data',
                cancelText: 'Cancelar',
                confirmText: 'Salvar',
                dateHintText: 'dd/mm/aaaa',
                fieldLabelText: 'Insira a data do seu nascimento',
                initialEntryMode: DatePickerEntryMode.calendar,
                initialDatePickerMode: DatePickerMode.year,
                smartDashesType: SmartDashesType.enabled,
                decoration: InputDecoration(
                  fillColor: CustomColors.whiteSecondary,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: GoogleFonts.poppins(
                    color: CustomColors.labelColor,
                  ),
                  label: Text(labelText),
                  labelStyle: GoogleFonts.poppins(
                    color: CustomColors.labelColor,
                  ),
                  errorStyle: GoogleFonts.poppins(
                    color: CustomColors.errorColor,
                  ),
                ),
                controller: controller,
                type: DateTimePickerType.date,
                dateMask: 'dd/MM/yyyy',
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                dateLabelText: 'Data',
                validator: (value) => validator(value) ? null : errorText,
              )
            : TextFormField(
                maxLength: maxLength,
                maxLines: textBox ? 3 : 1,
                keyboardType: keyboardType,
                controller: controller,
                obscureText: obscure!,
                style: GoogleFonts.poppins(
                  color: CustomColors.secondaryColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  fillColor: CustomColors.whiteSecondary,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: GoogleFonts.poppins(
                    color: CustomColors.labelColor,
                  ),
                  label: Text(labelText),
                  labelStyle: GoogleFonts.poppins(
                    color: CustomColors.labelColor,
                  ),
                  errorStyle: GoogleFonts.poppins(
                    color: CustomColors.errorColor,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => validator(value) ? null : errorText,
                onChanged: onChanged,
              ),
      ),
    );
  }
}
