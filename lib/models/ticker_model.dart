class TickerModel {
  String? pricedate;
  String? ticker;
  double? actualEps;
  double? estimatedEps;
  int? actualRevenue;
  int? estimatedRevenue;

  TickerModel(
      {this.pricedate,
      this.ticker,
      this.actualEps,
      this.estimatedEps,
      this.actualRevenue,
      this.estimatedRevenue});

  TickerModel.fromJson(Map<String, dynamic> json) {
    pricedate = json['pricedate'];
    ticker = json['ticker'];
    actualEps = json['actual_eps'];
    estimatedEps = json['estimated_eps'];
    actualRevenue = json['actual_revenue'];
    estimatedRevenue = json['estimated_revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pricedate'] = pricedate;
    data['ticker'] = ticker;
    data['actual_eps'] = actualEps;
    data['estimated_eps'] = estimatedEps;
    data['actual_revenue'] = actualRevenue;
    data['estimated_revenue'] = estimatedRevenue;
    return data;
  }
}
