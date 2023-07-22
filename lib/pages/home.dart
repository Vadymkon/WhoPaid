import 'package:flutter/material.dart';
import 'package:whopaid/pages/mainScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../generated/l10n.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  List whopaid = [];

  String _userToDo = "";

  @override
  void initState()
  {
    super.initState();
    whopaid.addAll(['First thing','Buy картошка', 'Somethink']);
  }

  void _mainmenu ()
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {return MainScreen();})
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).Todo_list),centerTitle: true,
        actions: [IconButton(onPressed: (){_mainmenu();}, icon: Icon(Icons.menu))],),
      body: ListView.builder(itemCount: whopaid.length ,itemBuilder: (BuildContext context, int index){
        return Dismissible( //смахивалка
            key: Key(whopaid[index]),
            child: Card(
              child: ListTile(
                title: AutoSizeText(maxLines: 1,whopaid[index]),
                trailing: IconButton(
                    icon: Icon(Icons.delete_outline_sharp),
                    onPressed: (){setState(() {whopaid.removeAt(index);});},
              ),
            ),
            ),
          onDismissed: (direction){
              //if (direction == DismissDirection.endToStart)
                setState(() {
                  whopaid.removeAt(index);
                });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context)
          {
            return AlertDialog(
              title: AutoSizeText(maxLines: 1,S.of(context).smthnk),
              content: TextField(
                onChanged: (String value){
                _userToDo = value;
              },),
              actions: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    whopaid.add(_userToDo);
                  });
                  Navigator.of(context).pop();
                }, child: AutoSizeText(maxLines: 1,S.of(context).add))
              ],
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
