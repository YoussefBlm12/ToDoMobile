import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/provider/task_provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/themes/color_manager.dart';

import '../../components/widgets/button.dart';
import '../../components/widgets/input_field.dart';




class AddTaskPage extends StatefulWidget {
  AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _time = DateFormat('hh:mm a').format(DateTime.now()).toString();
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> reapeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: const Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Time',
                      hint: _time,
                      widget: IconButton(
                        onPressed: ()=> _getTimeFromUser(isStartTime: true),
                        icon: const Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),

                ],
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: reapeatList
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      iconSize: 42,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectedRepeat = newvalue!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                      lable: 'Create Task',
                      onTap: () {
                        _validatedDate();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:  Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: ColorManager.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/person.jpeg'),
            radius: 18,
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  Column _colorPalette() {
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        Text(
          'Color',
          style:  GoogleFonts.lato(
              textStyle: TextStyle(
                color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? ColorManager.primary
                      : index == 1
                          ? ColorManager.pink
                          : ColorManager.orange,
                  radius: 14,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _validatedDate() {
    final taskProvider = Provider.of<TaskProvider>(context,listen: false) ;
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      taskProvider.addTasks(
          TaskModel(
            title: _titleController.text,
            isCompleted: false,
            color: _selectedColor,
            repeat: _selectedRepeat,
            description: _noteController.text,
            dueDate: DateFormat('yyyy-MM-dd').format(DateTime.parse(_selectedDate.toString())),
            time: _time,
          ));
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: ColorManager.pink,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    } else {
      print(
          "################## SOMETHING BAD HAPPENED #######################");
    }
  }


  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1998),
      lastDate: DateTime(2100),
    );

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print('it\'s null or something is wrong ');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
     TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
       builder: (context, Widget? child) {
         return MediaQuery(
           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!,

         );
       },
    );
      String _formattedTime = _pickedTime!.format(context);
      if(isStartTime){
        setState(() {
          _time = _formattedTime;
        });
      }else{
        print('time canceld or something is wrong ');
      }
  }
}
