import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/network/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());