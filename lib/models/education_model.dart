class UserEducation {
  // double _id;
  String? _institute;
  String? _startDate;
  String? _endDate;
  String? _qualification;

  UserEducation(/* this._id, */ this._qualification, this._institute,
      this._startDate, this._endDate);

  /*  get id => _id;

  set id(value) => _id = value; */

  factory UserEducation.fromJson(Map<String, dynamic> json) => UserEducation(
      json['institute'],
      json['qualification'],
      json['start_date'],
      json['end_date']);

  Map toJson() => {
        'institute': _institute,
        'start_date': _startDate,
        'end_date': _endDate,
        'qualification': _qualification,
      };

  get instituteName => _institute;

  set instituteName(value) => _institute = value;

  get startDate => _startDate;

  set startDate(value) => _startDate = value;

  String? get endDate => _endDate;

  set endDate(value) => _endDate = value;

  get qualification => _qualification;

  set qualification(value) => _qualification = value;
}
