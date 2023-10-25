
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/credentials.dart';
import '../models/task_model.dart';


class TaskServices {


  Future<List<TaskModel>> getAllTasks() async {
    List<TaskModel> tasks = [];
    var client = http.Client();
    try{
      var response = await client.get(
          Uri.parse('$apiBase/tasks'));
      if(response.statusCode == 200){
        final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
        tasks = parsed.map<TaskModel>((item) => TaskModel.fromJson(item)).toList();
      }
    }catch(e){
        print('error $e');
    }
    return tasks;
  }

  Future<String> addTask(TaskModel taskModel) async {
    String tasks = '';
    var client = http.Client();
    try{
      print('object&& ' );
      var response = await client.post(
          Uri.parse('$apiBase/tasks/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
              "title": taskModel.title,
              "description": taskModel.description,
              "dueDate": taskModel.dueDate,
              "isCompleted": taskModel.isCompleted,
              "time": taskModel.time,
              "repeat": taskModel.repeat,
              "color" : taskModel.color
          })
          );
      print('object ${response.body}' );

      if(response.statusCode == 200){
        tasks = response.body;
      }
    }catch(e){
        print('error $e');
    }
    return tasks;
  }

  Future<String> deleteTask(String idTask) async {
    String tasks = '';
    var client = http.Client();
    try{
      print('object&& ' );
      var response = await client.delete(
          Uri.parse('$apiBase/tasks/$idTask'),
          headers: {
            'Content-Type': 'application/json',
          },
          );
      print('object ${response.body}' );

      if(response.statusCode == 200){
        tasks = response.body;
      }
    }catch(e){
        print('error $e');
    }
    return tasks;
  }

  Future<String> makeTaskCompleted(String idTask) async {
    String tasks = '';
    var client = http.Client();
    try{
      print('object&& ' );
      var response = await client.put(
          Uri.parse('$apiBase/tasks/$idTask'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "isCompleted": true,
          }),
          );
      print('object ${response.body}' );

      if(response.statusCode == 200){
        tasks = response.body;
      }
    }catch(e){
        print('error $e');
    }
    return tasks;
  }



}