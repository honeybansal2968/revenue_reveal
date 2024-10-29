import 'package:flutter/material.dart';
import 'package:revenue_reveal/APIs/earning_ticker_api.dart';
import 'package:revenue_reveal/modules/earningChart/earning_chart_screen.dart';

class TranscriptScreen extends StatefulWidget {
  final String ticker;
  final String quarter;
  final List<EarningsData> data;

  const TranscriptScreen(
      {super.key,
      required this.ticker,
      required this.quarter,
      required this.data});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  bool isLoading = true;
  String transcript = "";
  @override
  void initState() {
    callTranscriptAPIs(widget.data.map((e) => e.toJson()).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Text(
                "Earnings Transcript\n${widget.ticker} - ${widget.quarter}",
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Loading..."),
                    ])
              : SingleChildScrollView(
                  child: Text(
                    transcript, // Replace with API response
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> callTranscriptAPIs(
      List<Map<String, dynamic>> earningsData) async {
    for (var entry in earningsData) {
      final year = int.parse(entry['quarter'].substring(0, 4));
      final month = int.parse(entry['quarter'].substring(5, 7));

      // Determine quarter based on the month
      int quarter;
      if (month >= 1 && month <= 3) {
        quarter = 1;
      } else if (month >= 4 && month <= 6) {
        quarter = 2;
      } else if (month >= 7 && month <= 9) {
        quarter = 3;
      } else {
        quarter = 4;
      }

      transcript = await fetchEarningsTranscript(widget.ticker, year, quarter);
      isLoading = false;
      setState(() {});
    }
  }
}
