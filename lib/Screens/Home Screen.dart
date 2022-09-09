import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

import 'Widgets/Text.dart';





class HomeScreen extends StatefulWidget {
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> _todoItems = [];
  TextEditingController controller = TextEditingController();
  final CustomTimerController _controller = CustomTimerController();

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(


        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(_todoItems[index]),
                    CustomTimer(
                        controller: _controller,
                        begin: Duration(),
                        end: Duration(
                            hours: 5
                        ),
                        builder: (time) {
                          return Text(
                            "${time.hours}:${time.minutes}:${time
                                .seconds}.${time.milliseconds}",
                            style: TextStyle(fontSize: 24.0),
                          );
                        }
                    ),
                    SizedBox(height: 24.0),
                    SizedBox(
                      width: 260,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            minWidth: 60,
                            color: Colors.green,
                            onPressed: () => _controller.start(),
                            child: Text("Start"),
                          ),
                          MaterialButton(
                            minWidth: 60,
                            color: Colors.blueAccent,
                            onPressed: () => _controller.pause(),
                            child: Text("Pause"),
                          ),
                          MaterialButton(
                            minWidth: 60,
                            color: Colors.redAccent,
                            onPressed: () => _controller.reset(),
                            child: Text("Reset"),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              actions: <Widget>[

                MaterialButton(
                    color: Colors.redAccent,
                    child: text().style("OK", 15),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  Widget _buildTodoList() {
    return ListView.builder(

      shrinkWrap: true,
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        return const SizedBox();
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 40,
          width: 340,
          child: ListTile(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
              tileColor: Colors.redAccent.withOpacity(0.5),
              title: Center(child: Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: text().style(todoText, 12),
              )),
              onTap: () => _promptRemoveTodoItem(index)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent.withOpacity(0.5),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: text().style('TASK ORGANISER', 18)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10),
              child: SizedBox(
                height: 40,
                width: 340,
                child: TextField(
                  controller: controller,
                  onSubmitted: (val) {
                    _addTodoItem(val);
                    setState(() {
                      controller.clear();
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Task...',
                      hintStyle: const TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 12,
                          fontWeight: FontWeight.w800
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 130,
                          bottom: 5
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )
                  ),
                ),
              ),
            ),
          ),
          _buildTodoList(),

        ],
      ),

    );
  }
}