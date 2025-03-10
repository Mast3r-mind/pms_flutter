class PatientData {
  String patientId;
  String name;
  String weight;
  String weightUnit;
  String height;
  String heightUnit;
  String dob;
  String dobUnit;

  PatientData({
    this.patientId = '',
    this.name = '',
    this.weight = '',
    this.weightUnit = 'Kgs',
    this.height = '',
    this.heightUnit = 'cm',
    this.dob = '',
    this.dobUnit = 'Days',
  });
} 