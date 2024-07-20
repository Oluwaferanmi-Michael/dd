import 'package:flutter/foundation.dart';

import '../../core/util/barrel.dart';

@immutable
class Strings {
  const Strings._();

  static const homeCardTitles = ['Notes', 'Tasks', 'Fidget', 'Relax', 'Focus'];

  static const cardDescriptions = [
    'Capture your thoughts instantly with easy, on-the-go note taking.',
    'Organize and prioritize your tasks to stay on top of your goals.',
    'Relieve Stress and stay focused with interactive fidget tools.',
    'Calm your mind with guided meditation and breathing exercises.',
    'Boost productivity with focus sessions and breaks.',
  ];

  static const cardIllustrations = [];
  static const cardColors = [];

  static const emptyState = 'Doesnt look like theres anything here let\'s get started';
}

@immutable
class Illustrations {
  const Illustrations._();

  static const emptyState = 'undraw_void_-3-ggu.svg';
  static const dd = 'DD.png';
}
