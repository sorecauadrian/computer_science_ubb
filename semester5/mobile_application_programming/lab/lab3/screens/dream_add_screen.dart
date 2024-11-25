import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dream.dart';
import '../providers/dream_provider.dart';

class DreamAddScreen extends StatefulWidget {
  @override
  _DreamAddScreenState createState() => _DreamAddScreenState();
}

class _DreamAddScreenState extends State<DreamAddScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String _title = '';
  String _description = '';
  int _rating = 5;
  bool _lucidity = false;

  void _saveDream() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<DreamProvider>(context, listen: false).addDream(
        Dream(
          id: DateTime.now().millisecondsSinceEpoch,
          date: _date,
          title: _title,
          description: _description,
          rating: _rating,
          lucidity: _lucidity,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add dream')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SwitchListTile(
                  title: Text('lucid'),
                  value: _lucidity,
                  onChanged: (value) => setState(() => _lucidity = value),
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text('$_date'.split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _date) {
                      setState(() {
                        _date = picked;
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'title',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'please enter a title' : null,
                  onSaved: (value) => _title = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  onSaved: (value) => _description = value!,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'rating',
                    prefixIcon: Icon(Icons.star),
                  ),
                  value: _rating,
                  items: List.generate(
                    5,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (value) => setState(() => _rating = value!),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveDream,
                  child: Text('save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}