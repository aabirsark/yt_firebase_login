class StreamHeader {
  String? connection;
  String? transferEncoding;
  String? date;
  String? contentEncoding;
  String? cfCacheStatus;
  String? reportTo;
  String? contentType;
  String? xXssProtection;
  String? server;
  String? altSvc;
  String? nel;
  String? cfRay;
  String? xContentTypeOptions;

  StreamHeader(
      {this.connection,
      this.transferEncoding,
      this.date,
      this.contentEncoding,
      this.cfCacheStatus,
      this.reportTo,
      this.contentType,
      this.xXssProtection,
      this.server,
      this.altSvc,
      this.nel,
      this.cfRay,
      this.xContentTypeOptions});

  StreamHeader.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    transferEncoding = json['transfer-encoding'];
    date = json['date'];
    contentEncoding = json['content-encoding'];
    cfCacheStatus = json['cf-cache-status'];
    reportTo = json['report-to'];
    contentType = json['content-type'];
    xXssProtection = json['x-xss-protection'];
    server = json['server'];
    altSvc = json['alt-svc'];
    nel = json['nel'];
    cfRay = json['cf-ray'];
    xContentTypeOptions = json['x-content-type-options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['connection'] = connection;
    data['transfer-encoding'] = transferEncoding;
    data['date'] = date;
    data['content-encoding'] = contentEncoding;
    data['cf-cache-status'] = cfCacheStatus;
    data['report-to'] = reportTo;
    data['content-type'] = contentType;
    data['x-xss-protection'] = xXssProtection;
    data['server'] = server;
    data['alt-svc'] = altSvc;
    data['nel'] = nel;
    data['cf-ray'] = cfRay;
    data['x-content-type-options'] = xContentTypeOptions;
    return data;
  }
}