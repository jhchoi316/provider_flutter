import 'package:flutter/material.dart';

final List<String> nation_list = <String>['Vietnam', 'Philippines','China'];
var selectedValue = 'Vietnam';

class SignUp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenuExample(),
            ),//nation
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
            Padding(padding: const EdgeInsets.only(top: 60.0), child: Container(),),
          ],

        ),

      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = nation_list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: nation_list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: nation_list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}