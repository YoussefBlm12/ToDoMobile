

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/themes/color_manager.dart';

import '../../components/widgets/button.dart';
import '../../components/widgets/task_tile.dart';
import '../../core/provider/task_provider.dart';
import '../../themes/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body : Consumer<TaskProvider>(
          builder: (context, value, child) {
            if(value.task.isEmpty){
              if(!value.checked){
                value.getAllTasks();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _addTaskBar(),
                _addDateBar(),
                const SizedBox(
                  height: 6,
                ),
                if(value.filteredTask.isEmpty)...[
                  const SizedBox(
                    height: 50,
                  ),
                  _noTaskMsg()
                ],
                _showTasks(value.filteredTask),
              ],
            );
          },
      ),
    );
  }

  AppBar _appBar() => AppBar(
    leading: IconButton(
      onPressed: () {
        ThemeServices().switchTheme();
        print(Get.isDarkMode.toString());
      },
      icon: Icon(
        Get.isDarkMode
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_round_outlined,
        size: 24,
        color: Get.isDarkMode ? ColorManager.white : ColorManager.black,// darkGreyClr,
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


  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              Text(
                'Today',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
          MyButton(
            lable: '+ Add Task',
            onTap: (){
              print("object");
               Get.toNamed('/addTask');
             // _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }


  _addDateBar() {
    return Container(
      child : Consumer<TaskProvider>(
          builder: (context, value, child) {
            return DatePicker(
              DateTime.now(),
              width: 70,
              height: 100,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: ColorManager.primary,
              dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              monthTextStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              dayTextStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              onDateChange: (newDate) {
                value.taskFiltered(newDate);
                print("newDate $newDate");
              },
            );
          },),
    );
  }

  _showTasks(List<TaskModel> task) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
         // var task = _taskController.taskList[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                horizontalOffset: 300,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheet(
                        context,
                        task[index],
                      );
                    },
                    child: TaskTile(
                      task: task[index],
                    ),
                  ),
                ),
              ),
            );
          },
        itemCount: task.length,
      ),
    );

  }



  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 6),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              children: [
                const SizedBox(
                  height: 6,
                ),
                SvgPicture.asset(
                  'assets/task.svg',
                  color: ColorManager.primary.withOpacity(0.6),
                  height: 90,
                  semanticsLabel: 'Task',
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "You do not have any tasks yet!\nAdd new tasks to make your days productive ",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }


  showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Consumer<TaskProvider>(
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              height: (task.isCompleted!
                  ? MediaQuery.of(context).size.height * 0.30
                  : MediaQuery.of(context).size.height * 0.40),
              color: Get.isDarkMode ? ColorManager.darkHeaderClr : Colors.white,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 6,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (task.isCompleted!
                      ? Container()
                      : _buildBottomSheet(
                      label: 'Task Completed',
                      onTap: () {
                        value.makeTaskCompleted(task.sId!);
                        Get.back();
                      },
                      clr: ColorManager.primary)),
                  _buildBottomSheet(
                      label: 'delete Task',
                      onTap: () {
                        value.deleteTasks(task.sId!);
                        Get.back();
                      },
                      clr: ColorManager.primary),
                  Divider(
                    color: Get.isDarkMode ? Colors.grey : ColorManager.darkGreyClr,
                  ),
                  _buildBottomSheet(
                      label: 'Cancel',
                      onTap: () {
                        Get.back();
                      },
                      clr: ColorManager.primary),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                ? Colors.grey[600]!
                : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))
                : GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Get.isDarkMode ? Colors.white : ColorManager.darkGreyClr,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )).copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}
