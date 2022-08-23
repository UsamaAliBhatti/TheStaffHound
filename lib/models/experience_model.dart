class UserExperienceModel {
  // double _id;
  String? _startDate;
  String? _endDate;
  String? _companyName;
  String? _userDesignation;

  UserExperienceModel(/* this._id, */ this._userDesignation, this._companyName,
      this._startDate, this._endDate);

/*   get id => _id;

  set id(value) => _id = value; */

  Map toJson() => {
        'startDate': _startDate,
        'endDate': _endDate,
        'companyName': _companyName,
        'userDesignation': _userDesignation
      };

  factory UserExperienceModel.fromJson(Map<String, dynamic> json) =>
      UserExperienceModel(json['userDesignation'], json['companyName'],
          json['startDate'], json['endDate']);
  get startDate => _startDate;

  set startDate(value) => _startDate = value;

  get endDate => _endDate;

  set endDate(value) => _endDate = value;

  get companyName => _companyName;

  set companyName(value) => _companyName = value;

  get userDesignation => _userDesignation;

  set userDesignation(value) => _userDesignation = value;
}
