import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/backend_service.dart';

final signalListProvider = FutureProvider<List<dynamic>>((ref) async {
  final backendService = BackendService();
  return await backendService.fetchTradingSignals();
});
