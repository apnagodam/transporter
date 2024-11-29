enum ConstitutionType {
  individual('Individual', 1),
  proprietorship('Proprietorship ', 2);
  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const ConstitutionType(this.label, this.type);

  final String label;
  final int type;
}


enum PropDocumentType {
  gst('GST', 1),
  msme('MSME ', 2),
  license('License ', 3);

  // partnership('Partnership ', 3),
  // company('Company ', 4);

  const PropDocumentType(this.label, this.type);

  final String label;
  final int type;
}
