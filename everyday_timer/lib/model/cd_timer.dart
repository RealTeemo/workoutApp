import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'dart:convert';

const uuid = Uuid();

enum Category{time, work, sets, cycle}
enum Type{emom, sets, rest, amrap, dValue, advanced}// will be used to change the text type and list.generate
enum WorkType {work, rest, prep}

enum ID{custom, amrap, rest}

const categoryIcons = {
  Category.time: Icon(Icons.timer),
  Category.work: Icon(Icons.fitness_center),
  Category.sets: Icon(Icons.more_time_sharp),
  Category.cycle: Icon(Icons.restart_alt) 
};

class StoredTimer{
  final int time;
  final String title;

  StoredTimer({required this.time, this.title="hey",});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'time' : time,
    };
  }

  factory StoredTimer.fromMap(Map<String, dynamic> map) {
    return StoredTimer(
      time: map['time'],
      title: map['title'],
    );
  }

}

class CdTimer {
  List<StoredTimer> setsOfTimer = [];
  final String? id;
  String title;
  int time;
  int sets;
  Color color;

  CdTimer({
    required this.time,
    this.title="",
    this.sets = 1,
    this.color = Colors.orange,
    List<StoredTimer>? setsOfTimer,
    id
  })  : id = id ?? uuid.v4(),
  setsOfTimer = setsOfTimer ?? <StoredTimer>[];



  void addTimer(StoredTimer cdTimer){
    setsOfTimer.add(cdTimer);
  }

  int totalTime(){
    int totalTime= 0;
    for(var temp in setsOfTimer){
      totalTime += temp.time;
    }
    return totalTime;
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'sets': sets,
      'color': color.value, // Store color as an int
      'setsOfTimer': setsOfTimer.map((storedTimer) => storedTimer.toMap()).toList(),
    };
  }

  factory CdTimer.fromMap(Map<String, dynamic> map) {
    return CdTimer(
      title: map['title'],
      time: map['time'],
      sets: map['sets'],
      color: Color(map['color']),
      setsOfTimer: List<Map<String, dynamic>>.from(map['setsOfTimer'])
          .map((storedTimerMap) => StoredTimer.fromMap(storedTimerMap))
          .toList(),
    );
  }

}