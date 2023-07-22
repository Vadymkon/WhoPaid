import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whopaid/extenstion.dart';
import 'package:whopaid/pages/history.dart';
import 'package:whopaid/pages/home.dart';
import 'package:whopaid/pages/mainMenu.dart';
import 'package:whopaid/pages/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:whopaid/pages/menu.dart';
import 'package:whopaid/pages/users.dart';
import 'package:whopaid/theme.dart';
import 'generated/l10n.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
     AdaptiveTheme (
       light: kLightTheme,
        dark: kDarkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (light,dark) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Bill()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
    localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,

    initialRoute: '/',
    routes: {
          '/': (context) => const Menu(),
          '/test_screen': (context) => const MainScreen(),
          '/users': (context) => const Users(),
          '/main_menu': (context) => MainMenu(),
          '/history': (context) => const History(),


      '/todo': (context) => const Home(),
    },
  ),
        ),
      ));
}

class Bill extends ChangeNotifier {

  List<String> users_list = [] ; //guys-names
  //Map<String,int> food = {}; // food and cost
  List<String> food = [];
  List<int> cost = [];
  List<List<dynamic>> state = [];
  bool isFirst = true;
  bool isLoadingData = false;
  int choosenUser = 0;
  String billText= "";


  String currency = "UAH";

  String bmaker1_bill = "";
  String bmaker2_foodtitle = "";
  String bmaker3_dishestitle = "";
  String bmaker4_missed = "";
  String bmaker5_foodmissed = "";
  String bmaker6_guymissed = "";
  String usetip = "";

  // gorizontal : dishes
  // vertical : guys


  void stateChange(String word)
  {
    int indexOfFood = food.indexOf(word);
    state[indexOfFood][choosenUser] = !state[indexOfFood][choosenUser];
    billUpdate();
    notifyListeners();
  }
  bool stateReturn(String word)
  {
    int indexOfFood = food.indexOf(word);
    return state[indexOfFood][choosenUser];
  }
  void chooseUser(String word)
  {
    print(choosenUser);
    choosenUser = users_list.indexOf(word);
    billUpdate();
    notifyListeners();
  }
  void usersListElemChange(int index, String word)
  {
      while (users_list.contains(word))
      word+='1';

    users_list[index] = word;

    billUpdate();
    notifyListeners();
  }
  void usersListAddElement(String word)
  {
    int len = users_list.length;
    while(len == users_list.length)
      {
    if (!users_list.contains(word)) users_list.add(word);
    else word+='1';
    }
    if (!state.isEmpty)
      for(int i =0; i<food.length; i++)
        state[i].add(false);

    billUpdate();
    notifyListeners();
  }
  void usersListAddElements(List<String> list)
  {
    users_list.addAll(list);
    if (!state.isEmpty)
      for(int i =0; i<food.length; i++)
        state[i].removeAt(state[i].length-1);
    billUpdate();
    notifyListeners();
  }
  void usersListRemoveByIndex(int index)
  {
    choosenUser = 0;
    users_list.removeAt(index);
    for(int i =0; i<food.length; i++)
      state[i].removeAt(index);
    billUpdate();
    notifyListeners();
  }

  void foodAddLists(List<String> listfood, List<String> listcost)
  {
    List<int> listcostint = [];
    for (int i =0; i<listcost.length; i++)
      {
        listcostint.add(int.parse(listcost[i]));
      }

    //specializing
    for (int i =0; i<listfood.length-1; i++)
      {
        bool isSamed = false;
        int unik = 2;
        for (int j = i+1; j<listfood.length; j++)
        {
          if (listfood[i]==listfood[j])
            {
              isSamed = true;
              listfood[j] += unik.toString();
              unik++;
            }
        }
        if (isSamed) listfood[i] += ' 1';
      }

    for (int i =0; i<listfood.length; i++)
    while (food.contains(listfood[i])) listfood[i] += ' 1';

    //Map<String,int> buffer_food_map = Map.fromIterables(listfood, listcostint);
    food.addAll(listfood);
    cost.addAll(listcostint);

    //matrixchange
    if (!state.isEmpty)
      {for (int i = 0; i < listfood.length; i++)
        {
          state.add([]);
          for (int j = 0; j < users_list.length; j++)
            state.last.add(false);
        }
      }

    billUpdate();
    notifyListeners();
  }
  void foodRemoveAt(String key)
  {
    /*
    2 users
    3 dish
    [[false, true],
    [false, false],
    [false, true]]
     */
    int index = food.indexOf(key);
    food.removeAt(index);
    cost.removeAt(index);
    if (!state.isEmpty) state.removeAt(index);
    billUpdate();
    notifyListeners();
  }
  void foodChange(String startkey,String key, String value)
  {
    int i = food.indexOf(startkey);
    food[i] = key;
    cost[i] = int.tryParse(value)!;
    billUpdate();
    notifyListeners();
  }

  void makeMatrix()
  {
    takeTemplateFood();
    if (isLoadingData == false) {
      state.clear();

      for (int i = 0; i < food.length; i++) {
        state.add([]);
        for (int j = 0; j < users_list.length; j++) {
          state[i].add(false);
        }
      }
      stateChange(food.last);
      print(state);

    }
  }

  List<double> costDived ()
  {
    List<double> costDivedList = cost.map((value) => value.toDouble()).toList();

    //подсчёт сколько это блюдо вообще ели
    for (int i = 0; i < food.length; i++) {
      double counter = 0;
      for (int j = 0; j < state[i].length; j++) {
        if (state[i][j]==true) ++counter;
      }
      if (counter!=0) costDivedList[i] /= counter;
        else costDivedList[i] = 0;
    }
    return costDivedList;
  }

  void billUpdate() {
    if (!state.isEmpty)
      {
        billText = "";
        billText += bmaker1_bill + ' ' + cost.reduce((value, element) => value + element).toString() + " $currency\n\n";
        billText += "${bmaker2_foodtitle}";
        List<double> divedCost = costDived(); //дельная цена для каждого блюда
        for (int i =0; i<users_list.length; i++) {
          billText += users_list[i] + ' - ';
          String buffer = "";
          double costForUser = 0;
          for (int j = 0; j < food.length; j++) {
            if (state[j][i] == true) {
              buffer += "${food[j]}(${divedCost[j].toStringAsFixedLength(2)})";
              if (j!=food.length-1) buffer+= ", ";
              costForUser += divedCost[j];
            }
          }
          if (costForUser != 0)
            billText += "${costForUser.toStringAsFixedLength(2)} $currency (${buffer})\n";
          else billText += bmaker6_guymissed;
        }

        billText += "\n${bmaker3_dishestitle}";
        for (int i =0; i<food.length; i++)
          {
            billText += "${food[i]} - ";
            int counter = 0;
            for (int j = 0; j < users_list.length; j++) {
              if (state[i][j] == true) {
                ++counter;
                billText += "${users_list[j].split('.').toList().last.trim()}, ";
              }
            }
            if (counter != 0) billText += "${cost[i]}/${counter} = ${divedCost[i].toStringAsFixedLength(2)} $currency\n";
            else billText += bmaker5_foodmissed;
          }


      }
    billText = billText.replaceAll("\\n", "\n");
    notifyListeners();
  }

  void takeTemplateFood()
  {
    if (food.isEmpty) {
      food.addAll(['Pizza']);
      cost.addAll([100]);
    }
  }

  void clearAll()
  {
    billText=usetip;
    choosenUser = 0;
    isFirst = true;
    isLoadingData = false;
    users_list.clear();
    food.clear();
    cost.clear();
    state.clear();
    notifyListeners();
  }
  void saveToHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');

    try {
      if (!await historyDirectory.exists()) {
        await historyDirectory.create(recursive: true);
      }

      final fileList = historyDirectory.listSync();
      final fileNumber = fileList.length + 1;
      final file = File('${historyDirectory.path}/bill_data$fileNumber.txt');

      final data = {
        'users_list': users_list,
        'food': food,
        'cost': cost,
        'state': state,
        'isFirst': isFirst,
        'choosenUser': choosenUser,
        'billText': billText,
        'currency': currency,
        'usetip': usetip,
      };

      await file.writeAsString(jsonEncode(data));
      print('Data successfully saved to file: ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void loadFromHistory(int fileNumber) async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');
    final file = File('${historyDirectory.path}/bill_data$fileNumber.txt');

    try {
      if (await file.exists()) {
        final data = await file.readAsString();
        final parsedData = jsonDecode(data) as Map<String, dynamic>;

        users_list = List<String>.from(parsedData['users_list']);
        food = List<String>.from(parsedData['food']);
        cost = List<int>.from(parsedData['cost']);
        state = List<List<bool>>.from(parsedData['state']);
        isFirst = parsedData['isFirst'] as bool;
        choosenUser = parsedData['choosenUser'] as int;
        billText = parsedData['billText'] as String;
        currency = parsedData['currency'] as String;
        usetip = parsedData['usetip'] as String;

        print('Data successfully loaded from file: ${file.path}');
      } else {
        print('File not found: ${file.path}');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  void loadFromHistoryData(String data) {
    isLoadingData = true;
    final parsedData = jsonDecode(data) as Map<String, dynamic>;
    print(parsedData['state'].toString());
    users_list = List<String>.from(parsedData['users_list']);
    food = List<String>.from(parsedData['food']);
    cost = List<int>.from(parsedData['cost']);
    state = List<List<dynamic>>.from(parsedData['state']);
    isFirst = parsedData['isFirst'] as bool;
    choosenUser = 0;
    billText = parsedData['billText'] as String;
    currency = parsedData['currency'] as String;
    usetip = parsedData['usetip'] as String;

    notifyListeners();
  }

  String getTotalCost(String filePath) {
    final file = File(filePath);
    final data = file.readAsStringSync();
    final parsedData = jsonDecode(data) as Map<String, dynamic>;

    final List<int> costList = List<int>.from(parsedData['cost']);
    final int totalCost = costList.fold(0, (sum, cost) => sum + cost);

    return '$totalCost $currency';
  }


}