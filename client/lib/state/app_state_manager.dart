import 'package:todo_client/http_client/todo_client.dart';
import 'package:todo_client/model/todo.dart';
import 'package:todo_client/state/state_types.dart';
import 'package:todo_client/constants.dart' as constants;

class AppStateManager<T extends StateTypes>{
  final Map<T, dynamic> states = <T, dynamic>{};
  final Map<T, List<dynamic>> observerObjects = <T, List<dynamic>>{};
  TodoClient? _todoClient;

  AppStateManager._internal();
  static final _appStateManager = AppStateManager._internal();

  static AppStateManager instance() {
    return _appStateManager;
  }

  /// if you want to initialize states from db
  /// you can use these methods: 
  /// setStateInitializer and initState methods
  void setStateInitializer(TodoClient todoClient){
    _todoClient=todoClient;
  }

  void initState(T stateKey){
    () async {
      var todos = await _todoClient?.fetchAll('todo/all');
      update(stateKey, todos);
    }();
  }

  void set(T state, dynamic value){
      states[state] = value;
  }

  dynamic get(T state){
    if(states.containsKey(state)){
      return states[state];
    }
    constants.log.warning("$state cannot be found");
    return null;
  }

  void update(T state, dynamic value){
    constants.log.info("The value of a key is updated {$state:$value}");
    states[state]=value;
    observerObjects[state]?.forEach((element) {element();});
  }

  void register(T state, dynamic object){
    constants.log.info("Register is called: {$state: $object}");
    if(!observerObjects.containsKey(state)){
      observerObjects[state] = List<dynamic>.empty(growable: true);
    }
    if(!observerObjects[state]!.contains(object)){
      observerObjects[state]?.add(object);
    }
  }

}