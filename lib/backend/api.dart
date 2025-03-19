import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:salam_hackathon_front/models/models.dart';

const baseUrl = 'http://localhost:8080';

Future<List<Learning>> getLearnings(String id) async {
  try {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/learnings/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    print(jsonDecode(response.body));
    return (jsonDecode(response.body) as List)
        .map((e) => Learning.fromJson(e))
        .toList();
  } catch (e) {

    print(e);
    return [];

  }
}

Future<List<Project>> getProjects(String id, String parentId) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/projects/$id'),
      body: jsonEncode({'id': parentId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    List<Project> projects = (jsonDecode(response.body) as List)
        .map((e) => Project.fromJson(e))
        .toList();
    projects.sort((a, b) => a.order.compareTo(b.order));


    return projects;
  } catch (e) {

    print(e);
    return [];

  }
}

Future<List<Task>> getTasks(String id, String parentId) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/tasks/$id'),
      body: jsonEncode({'id': parentId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    List<Task> tasks = (jsonDecode(response.body) as List)
        .map((e) => Task.fromJson(e))
        .toList();
    tasks.sort((a, b) => a.order.compareTo(b.order));


    return tasks;
  } catch (e) {

    print(e);
    return [];

  }
}

Future<bool> checkTask(String id, String parentId) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/tasks/check/$id'),
      body: jsonEncode({'id': parentId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    List<Task> tasks = (jsonDecode(response.body) as List)
        .map((e) => Task.fromJson(e))
        .toList();
    tasks.sort((a, b) => a.order.compareTo(b.order));


    return true;
  } catch (e) {

    print(e);
    return false;

  }
}

Future<bool> newLearning(String id, language, framework, goal, level) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/new-learning/$id'),
      body: jsonEncode({'goal' : goal, 'language' : language, 'framework' : framework, 'level' : level}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    print(jsonDecode(response.body));
    return true;
  } catch (e) {

    print(e);
    return false;

  }
}

Future<List<dynamic>> getSuggest(String level, goal, preference) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/suggest'),
      body: jsonEncode({'level': level, 'goal':goal, 'preference' : preference}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } catch (e) {

    print(e);
    return [];

  }
}

Future<List<dynamic>> getHelp(String language, framework, project, task) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/help'),
      body: jsonEncode({'language' : language, 'framework' : framework, 'project' : project, 'task' : task}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } catch (e) {

    print(e);
    return [];

  }
}