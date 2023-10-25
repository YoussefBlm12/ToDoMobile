class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? dueDate;
  bool? isCompleted;
  String? time;
  String? repeat;
  int? color;

  TaskModel(
      {this.sId,
        this.title,
        this.description,
        this.dueDate,
        this.isCompleted,
        this.time,
        this.repeat,
        this.color,
      });

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    dueDate = json['dueDate'];
    isCompleted = json['isCompleted'];
    time = json['time'];
    repeat = json['repeat'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['dueDate'] = this.dueDate;
    data['isCompleted'] = this.isCompleted;
    data['time'] = this.time;
    data['repeat'] = this.repeat;
    data['color'] = this.color;
    return data;
  }
}