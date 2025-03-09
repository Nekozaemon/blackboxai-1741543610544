import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/signal_list_provider.dart';

class TradeSignalsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signalsAsyncValue = ref.watch(signalListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Signals'),
      ),
      body: signalsAsyncValue.when(
        data: (signals) => ListView.builder(
          itemCount: signals.length,
          itemBuilder: (context, index) {
            final signal = signals[index];
            return ListTile(
              title: Text('${signal['symbol']} - ${signal['signal_type']}'),
              subtitle: Text('Confidence: ${signal['confidence']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('TP: ${signal['tp']}'),
                  Text('SL: ${signal['sl']}'),
                ],
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
