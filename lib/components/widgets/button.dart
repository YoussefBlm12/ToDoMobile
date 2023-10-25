import 'package:flutter/material.dart';
import 'package:todo/themes/color_manager.dart';


class MyButton extends StatelessWidget {
  MyButton({required this.lable, required this.onTap});

  final String lable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          color: ColorManager.bleu,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          lable,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
