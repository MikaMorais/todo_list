import 'package:flutter/material.dart';
import 'package:tarefas_todo_list/temas/temas.dart';
import 'package:tarefas_todo_list/telas/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lista de Tarefas',
    home: Home(),
    themeMode: ThemeMode.system,
    theme: lightTheme(),
    darkTheme: darkTheme(),
  ));
}
