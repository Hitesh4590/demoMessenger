

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage the selected navigation bar index
final selectedNavIndexProvider = StateProvider<int>((ref) => 0);