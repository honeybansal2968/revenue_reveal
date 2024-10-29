import 'package:flutter/material.dart';
import 'package:revenue_reveal/APIs/earning_ticker_api.dart';
import 'package:revenue_reveal/modules/transcript/transcript_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningsChartScreen extends StatefulWidget {
  final String ticker;
  const EarningsChartScreen({super.key, required this.ticker});

  @override
  _EarningsChartScreenState createState() => _EarningsChartScreenState();
}

class _EarningsChartScreenState extends State<EarningsChartScreen> {
  bool isLoading = true;
  final List<EarningsData> _earningsData = [];

  @override
  void initState() {
    super.initState();
    getEarningsData(); // replace with API data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Earnings Overview for ${widget.ticker}")),
      body: isLoading
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 20),
                Text("Loading..."),
              ],
            )
          : SfCartesianChart(
              title: const ChartTitle(text: 'Estimated vs Actual Earnings'),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: [
                LineSeries<EarningsData, String>(
                  name: 'Estimated',
                  dataSource: _earningsData,
                  xValueMapper: (EarningsData data, _) => data.quarter,
                  yValueMapper: (EarningsData data, _) => data.estimated,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (ChartPointDetails details) {
                    _openTranscriptScreen(context, details.pointIndex!);
                  },
                ),
                LineSeries<EarningsData, String>(
                  name: 'Actual',
                  dataSource: _earningsData,
                  xValueMapper: (EarningsData data, _) => data.quarter,
                  yValueMapper: (EarningsData data, _) => data.actual,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  onPointTap: (ChartPointDetails details) {
                    _openTranscriptScreen(context, details.pointIndex!);
                  },
                ),
              ],
              primaryXAxis: const CategoryAxis(),
              primaryYAxis: const NumericAxis(
                labelFormat: '\${value}M',
              ),
            ),
    );
  }

  void _openTranscriptScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TranscriptScreen(
          ticker: widget.ticker,
          quarter: _earningsData[index].quarter,
          data: _earningsData,
        ),
      ),
    );
  }

  Future<void> getEarningsData() async {
    var data = await fetchEarningsData(widget.ticker);
    for (var i = 0; i < data.length; i++) {
      _earningsData.insert(
          0,
          EarningsData(
            data[i]['pricedate'],
            double.parse(
                (data[i]['estimated_revenue'] / 100000000).toStringAsFixed(2)),
            double.parse(
                (data[i]['actual_revenue'] / 100000000).toStringAsFixed(2)),
          ));
    }
    isLoading = false;
    setState(() {});
  }
}

class EarningsData {
  EarningsData(this.quarter, this.estimated, this.actual);

  final String quarter;
  final double estimated;
  final double actual;

  Map<String, dynamic> toJson() {
    return {
      'quarter': quarter,
      'estimated': estimated,
      'actual': actual,
    };
  }
}
