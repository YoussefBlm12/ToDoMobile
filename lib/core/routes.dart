


import 'package:get/get.dart';
import 'package:todo/views/home/home_page.dart';

import '../views/home/add_task_page.dart';

List<GetPage> routes = [
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/addTask',
    page: () =>  AddTaskPage(),
    transition: Transition.native,
  ),

];
