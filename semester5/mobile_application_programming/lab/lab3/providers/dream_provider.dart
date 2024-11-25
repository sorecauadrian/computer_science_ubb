import 'package:flutter/material.dart';
import '../models/dream.dart';

class DreamProvider with ChangeNotifier
{
  List<Dream> _dreams = [
    Dream(id: 1, date: DateTime.now().subtract(Duration(days: 1)), title: 'Flying Adventure', description: 'I was flying over mountains and felt completely free.', rating: 5, lucidity: true),
    Dream(id: 2, date: DateTime.now().subtract(Duration(days: 2)), title: 'Meeting an Old Friend', description: 'I had a deep conversation with someone from my childhood.', rating: 4, lucidity: false,),
    Dream(id: 3, date: DateTime.now(), title: 'Underwater World', description: 'Explored an underwater city filled with colorful creatures.', rating: 5, lucidity: true,)
  ];

  List<Dream> get dreams => [..._dreams]; // returning a copy to avoid direct modification

  void addDream(Dream dream) {
    _dreams.add(dream);
    notifyListeners(); // notifying UI about the state change
  }

  void updateDream(Dream updatedDream) {
    int index = _dreams.indexWhere((dream) => dream.id == updatedDream.id);
    if (index != -1) {
      _dreams[index] = updatedDream;
      notifyListeners(); // notifying UI about the state change
    }
  }

  void deleteDream(int id) {
    _dreams.removeWhere((dream) => dream.id == id);
    notifyListeners(); // notifying UI about the state change
  }

  Dream? findDreamById(int id) {
    return _dreams.firstWhere((dream) => dream.id == id);
  }
}