




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task_model.dart';
import '../../services/task_services.dart';

class TaskProvider extends ChangeNotifier{

  List<TaskModel> task = [];
  List<TaskModel> filteredTask = [];
  bool checked = false;
  DateTime dateSelected = DateTime.now();

  getAllTasks() async {
    task.clear();
    await  TaskServices().getAllTasks().then((value) {
      task.addAll(value);
    });
    taskFiltered(dateSelected);
    checked = true;
    notifyListeners();
  }
  addTasks(TaskModel taskModel) async {
    String reponse = '';
    await  TaskServices().addTask(taskModel).then((value) {
      reponse =  value;
    });
    print(reponse);
    checked = false;
    task.clear();
    notifyListeners();
  }


  deleteTasks(String idTask) async {
    String reponse = '';
    print(idTask);
    await  TaskServices().deleteTask(idTask).then((value) {
      reponse =  value;
    });
    print(reponse);
    checked = false;
    task.clear();
    notifyListeners();
  }

  makeTaskCompleted(String idTask) async {
    String reponse = '';
    print(idTask);
    await  TaskServices().makeTaskCompleted(idTask).then((value) {
      reponse =  value;
    });
    print(reponse);
    checked = false;
    task.clear();
    notifyListeners();
  }

  taskFiltered(DateTime date) async {
    filteredTask.clear();
    if(task.isEmpty){
      await getAllTasks();
    }
    if(task.isNotEmpty){
      for(int i = 0 ; i < task.length ; i++ ){
        print(' newss ' + ((date.difference(DateTime.parse(task[i].dueDate!)).inDays) % 7).toString());
        DateTime taskDueDate = DateTime.parse(task[i].dueDate!);
        if(DateFormat('yyyy-MM-dd').format(DateTime.parse(task[i].dueDate!)) ==
            DateFormat('yyyy-MM-dd').format(date)
          || task[i].repeat == 'Daily'
          || ((task[i].repeat == 'Weekly') && ((date.difference(DateTime.parse(task[i].dueDate!)).inDays) % 7) == 0)
          || ((task[i].repeat == 'Monthly') && date.day == taskDueDate.day )
        ){
          filteredTask.add(task[i]);
        }
      }
    }

      notifyListeners();
  }

  bool compareDates(String dateString1, String dateString2) {
    DateTime date1 = DateTime.parse(dateString1);
    DateTime date2 = DateTime.parse(dateString2);

    print('ddddd');
    if (date1.isBefore(date2)) {
      return false; // Date 1 is earlier than Date 2
    } else if (date1.isAfter(date2)) {
      return false; // Date 1 is later than Date 2
    } else {
      return true; // Date 1 and Date 2 are the same
    }
  }


}