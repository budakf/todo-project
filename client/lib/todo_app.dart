import 'package:flutter/material.dart';
import 'package:todo_client/http_client/todo_client.dart';

import 'package:todo_client/state/app_state_manager.dart';
import 'package:todo_client/state/state_types.dart';
import 'package:todo_client/widgets/add_button.dart';
import 'package:todo_client/widgets/button_group.dart';
import 'package:todo_client/widgets/edit_text.dart';
import 'package:todo_client/widgets/footer.dart';
import 'package:todo_client/widgets/search_bar.dart';
import 'package:todo_client/widgets/todo_list.dart';
import 'package:todo_client/constants.dart' as constants;

class TodoApp extends StatefulWidget {
  AppStateManager<StateTypes> appStateManager;
  TodoClient todoClient = TodoClient(constants.host, constants.baseEndpoint);
  TodoApp({super.key}): appStateManager = AppStateManager.instance(){
    constants.log.fine('Todo App started');
    appStateManager.setStateInitializer(todoClient);
  }

  @override
  State<TodoApp> createState() => TodoAppMainWidget();
}

class TodoAppMainWidget extends State<TodoApp> {
  AppStateManager<StateTypes> appStateManager;
  TodoAppMainWidget(): appStateManager = AppStateManager.instance();

  @override
  Widget build(BuildContext context) {
    constants.log.fine('Todo App Widget started');
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Todo App',
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.green,
            ),
          ),
        ),
        body: Column(
          children:[

            const Expanded(
              flex:1,
              child: MySearchBar(),
            ),

            Expanded(
              flex:12,
              child: Row(
                children: [
                  
                  Expanded(
                    flex:1,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),

                  Expanded(
                    flex:8,
                    child: Column(

                      children: [

                        const Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(flex:9, child: EditText()),
                              Expanded(flex:1, child: AddButton()),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 10,
                          child: Row(
                            children: [

                              Expanded(
                                flex:1,
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),

                              // List Item will be here
                              const Expanded(
                                flex:8,
                                child: TodoList(),
                              ),

                              Expanded(
                                flex:1,
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex:1,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),

                ],
              ),
            ),

            const Expanded(
              flex:1,
              child: Footer()
            )

          ],
        )
      ),
    );

  }

  
}