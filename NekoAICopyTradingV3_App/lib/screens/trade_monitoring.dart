import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/trade_list_provider.dart';

class TradeMonitoringScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesAsyncValue = ref.watch(tradeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Monitoring'),
      ),
      body: tradesAsyncValue.when(
        data: (trades) => ListView.builder(
          itemCount: trades.length,
          itemBuilder: (context, index) {
            final trade = trades[index];
            return ListTile(
              title: Text('${trade['symbol']} - ${trade['status']}'),
              subtitle: Text('Entry Price: ${trade['entry_price']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Price: ${trade['current_price']}'),
                  Text('TP: ${trade['tp']}'),
                  Text('SL: ${trade['sl']}'),
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
