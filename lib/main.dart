import 'package:flutter/material.dart';

import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topicos avanzados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topicos avanzados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Agregar', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text('Listar todos', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('Actualizar primero', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('Borrar', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnTelephone  : 7752318
    };
    final id = await dbHelper.insert(row);
    print('Inserta fila id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('Lista todas las columnas:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnTelephone  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('Actualizar $rowsAffected filas(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('Borrar $rowsDeleted filas(s): filas $id');
  }
}