class HistoryModel {
  final String trnID, trnDescription, amount, sourceMobile, targetMobile, trnDateTime, fee, mobileRef, refID;

  HistoryModel({
    this.trnID,
    this.trnDescription,
    this.amount,
    this.sourceMobile,
    this.targetMobile,
    this.trnDateTime,
    this.fee,
    this.mobileRef,
    this.refID,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      trnID: json['trnID'],
      trnDescription: json['trnDescription'],
      amount: json['amount'],
      sourceMobile: json['sourceMobile'],
      targetMobile: json['targetMobile'],
      trnDateTime: json['trnDateTime'],
      fee: json['fee'],
      mobileRef: json['mobileRef'],
      refID: json['refID'],
    );
  }
}
