class Learning {
  final String id;
  final String language;
  final String level;
  final String framework;
  final String goal;
  final String title;
  final String description;
  final int progress;

  Learning({
    required this.id,
    required this.language,
    required this.level,
    required this.framework,
    required this.goal,
    required this.title,
    required this.description,
    required this.progress,
  });

  factory Learning.fromJson(Map<String, dynamic> json) {
    return Learning(
      id: json['id'],
      description: json['description'],
      framework: json['framework'],
      goal: json['goal'],
      language: json['language'],
      level: json['level'],
      progress: json['progress'],
      title: json['title'],
    );
  }
}

class Project {
  final String id;
  final int order;
  final String title;
  final String description;
  final bool isLocked;
  final String learningId;
  final int progress;
  final int tasknum;

  Project({
    required this.id,
    required this.tasknum,
    required this.order,
    required this.title,
    required this.description,
    required this.isLocked,
    required this.learningId,
    required this.progress,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      description: json['description'],
      isLocked: json['isLocked'],
      learningId: json['learningId'],
      order: json['order'],
      progress: json['progress'],
      tasknum: json['tasknum'],
      title: json['title'],
    );
  }
}

class Task {
  final String id;
  final int order;
  final String title;
  final String description;
  final bool completed;
  final String projectId;

  Task({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.completed,
    required this.projectId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      completed: json['completed'],
      description: json['description'],
      order: json['order'],
      projectId: json['projectId'],
      title: json['title'],
    );
  }
}