import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dream.dart';
import '../providers/dream_provider.dart';

class DreamDetailsScreen extends StatefulWidget {
  @override
  _DreamDetailsScreenState createState() => _DreamDetailsScreenState();
}

class _DreamDetailsScreenState extends State<DreamDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late Dream _dream;
  late DateTime _date;
  late String _title;
  late String _description;
  late int _rating;
  late bool _lucidity;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      _dream = Provider.of<DreamProvider>(context, listen: false).findDreamById(id)!;

      _date = _dream.date;
      _title = _dream.title;
      _description = _dream.description;
      _rating = _dream.rating;
      _lucidity = _dream.lucidity;

      _isInitialized = true;
    }
  }

  void _saveDream() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<DreamProvider>(context, listen: false).updateDream(
        Dream(
          id: _dream.id,
          date: _date,
          title: _title,
          description: _description,
          rating: _rating,
          lucidity: _lucidity,
        )
      );
      Navigator.pop(context);
    }
  }

  void _deleteDream() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete Dream'),
        content: Text('are you sure you want to delete this dream?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<DreamProvider>(context, listen: false).deleteDream(_dream.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit dream'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteDream,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  initialValue: _title,
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
                  initialValue: _description,
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
                  onChanged: (value) => setState(() {
                    _rating = value!;
                  }),
                  onSaved: (value) => _rating = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveDream,
                  child: Text('save changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
