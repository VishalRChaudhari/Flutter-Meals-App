import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/data/dummy_data.dart';

final meals_Provider = Provider((ref) {
    return dummyMeals;
});