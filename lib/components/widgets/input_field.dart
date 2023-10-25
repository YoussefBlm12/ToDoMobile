import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/themes/color_manager.dart';


class InputField extends StatelessWidget {
  const InputField({
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:  GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,
                      readOnly: widget != null ? true : false,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      cursorColor:
                          Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget ?? Container(),
                ],
              ),
            ),
          ],
        ));
  }
}
