import 'package:flutter/material.dart';
import 'package:revenue_reveal/modules/earningChart/earning_chart_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _tickerController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Company Earnings Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tickerController,
              decoration: const InputDecoration(
                labelText: "Enter Company Ticker (e.g., MSFT)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EarningsChartScreen(
                      ticker: _tickerController.text,
                    ),
                  ),
                );
              },
              child: const Text("Get Earnings Data"),
            ),
          ],
        ),
      ),
    );
  }
}
