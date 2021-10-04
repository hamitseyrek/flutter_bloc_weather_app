import 'package:flutter/material.dart';

class SelectCityWidget extends StatefulWidget {
  SelectCityWidget({Key? key}) : super(key: key);

  @override
  _SelectCityWidgetState createState() => _SelectCityWidgetState();
}

class _SelectCityWidgetState extends State<SelectCityWidget> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select City'),
      ),
      body: Form(
          child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Select City',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
              icon: const Icon(Icons.search))
        ],
      )),
    );
  }
}
