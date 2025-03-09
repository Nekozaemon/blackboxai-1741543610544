import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/signal_list_provider.dart';
import '../state_management/trade_list_provider.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signalsAsyncValue = ref.watch(signalListProvider);
    final tradesAsyncValue = ref.watch(tradeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: signalsAsyncValue.when(
              data: (signals) => ListView.builder(
                itemCount: signals.length,
                itemBuilder: (context, index) {
                  final signal = signals[index];
                  return ListTile(
                    title: Text('${signal['symbol']} - ${signal['signal_type']}'),
                    subtitle: Text('Confidence: ${signal['confidence']}'),
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e) => Center(child: Text('Error: $e')),
            ),
          ),
          Expanded(
            child: tradesAsyncValue.when(
              data: (trades) => ListView.builder(
                itemCount: trades.length,
                itemBuilder: (context, index) {
                  final trade = trades[index];
                  return ListTile(
                    title: Text('${trade['symbol']} - ${trade['status']}'),
                    subtitle: Text('Entry Price: ${trade['entry_price']}'),
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
