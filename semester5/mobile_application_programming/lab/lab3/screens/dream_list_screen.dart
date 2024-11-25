import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dream_provider.dart';

class DreamListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dreams = Provider.of<DreamProvider>(context).dreams;

    return Scaffold(
      appBar: AppBar(
        title: Text('dreams'),
      ),
      body: ListView.builder(
        itemCount: dreams.length,
        itemBuilder: (context, index) {
          final dream = dreams[index];
          return ListTile(
            title: Text(dream.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dream.description.length > 30
                    ? dream.description.substring(0, 30) + '...'
                    : dream.description),
                SizedBox(height: 5),
                Text(dream.date.toLocal().toString().split('.')[0],
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: Icon(dream.lucidity ? Icons.lightbulb : Icons.nights_stay),
            onTap: () => Navigator.pushNamed(
              context,
              '/details',
              arguments: dream.id,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: Icon(Icons.add),
      ),
    );
  }
}