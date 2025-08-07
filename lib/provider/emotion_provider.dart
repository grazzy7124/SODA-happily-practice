
import 'package:flutter/material.dart';
import 'package:ver1/model/emotion_model.dart';


class EmotionProvider with ChangeNotifier {
  EmotionModel _emotion = EmotionModel(value: 0);

  EmotionModel get emotion {
    return _emotion;
  }

  void setEmotion (double newEmotion) {
    _emotion.value = newEmotion;
    notifyListeners();
  }
}