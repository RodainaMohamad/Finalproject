class AddReportModel {
String? uploadDate;
String? reportDetails;
num? patientId;
num? medicalStaffId;

AddReportModel({
      this.uploadDate, 
      this.reportDetails, 
      this.patientId, 
      this.medicalStaffId
});

  AddReportModel.fromJson(dynamic json) {
    uploadDate = json['uploadDate'];
    reportDetails = json['reportDetails'];
    patientId = json['patientId'];
    medicalStaffId = json['medicalStaffId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if(uploadDate!=null)map['uploadDate']=uploadDate;
    if(reportDetails!=null)map['reportDetails']=reportDetails;
    if(patientId!=null)map['patientId']=patientId;
    if(medicalStaffId!=null)map['medicalStaffId']=medicalStaffId; // optional not needed
    return map;
  }
}