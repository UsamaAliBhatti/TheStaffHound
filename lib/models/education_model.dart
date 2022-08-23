class UserEducation {
  // double _id;
  String _instituteName;
  String _startDate;
  String _endDate;
  String _qualification;

  UserEducation(/* this._id, */ this._qualification, this._instituteName,
      this._startDate, this._endDate);

  /*  get id => _id;

  set id(value) => _id = value; */


  factory UserEducation.fromJson(Map<String, dynamic> json) =>
      UserEducation(json['instituteName'], json['qualification'],
          json['startDate'], json['endDate']);

  Map toJson() => {
        'instituteName': _instituteName,
        'startDate': _startDate,
        'endDate': _endDate,
        'qualification': _qualification,
      };

  get instituteName => _instituteName;

  set instituteName(value) => _instituteName = value;

  get startDate => _startDate;

  set startDate(value) => _startDate = value;

  get endDate => _endDate;

  set endDate(value) => _endDate = value;

  get qualification => _qualification;

  set qualification(value) => _qualification = value;
}

