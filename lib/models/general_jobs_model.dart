class GeneralJobModel {
  String companyLogo;
  String companyName;
  String jobTitle;
  String jobLocation;
  String jobSalaryRange;
  String jobDescription;
  String salaryRangeType;
  String jobType;
  String jobCategory;
  List<String> jobRequirements;
  List<String> requiredSkillsList;

  get getRequiredSkillsList => requiredSkillsList;

  set setRequiredSkillsList(requiredSkillsList) =>
      this.requiredSkillsList = requiredSkillsList;

  get getCompanyLogo => companyLogo;

  set setCompanyLogo(companyLogo) => this.companyLogo = companyLogo;

  get getCompanyName => companyName;

  set setCompanyName(companyName) => this.companyName = companyName;

  get getJobTitle => jobTitle;

  set setJobTitle(jobTitle) => this.jobTitle = jobTitle;

  get getJobLocation => jobLocation;

  set setJobLocation(jobLocation) => this.jobLocation = jobLocation;

  get getJobSalaryRange => jobSalaryRange;

  set setJobSalaryRange(jobSalaryRange) => this.jobSalaryRange = jobSalaryRange;

  get getJobDescription => jobDescription;

  set setJobDescription(jobDescription) => this.jobDescription = jobDescription;

  get getSalaryRangeType => salaryRangeType;

  set setSalaryRangeType(salaryRangeType) =>
      this.salaryRangeType = salaryRangeType;

  get getJobType => jobType;

  set setJobType(jobType) => this.jobType = jobType;

  get getJobCategory => jobCategory;

  set setJobCategory(jobCategory) => this.jobCategory = jobCategory;

  get getJobRequirements => jobRequirements;

  set setJobRequirements(jobRequirements) =>
      this.jobRequirements = jobRequirements;
  GeneralJobModel(
      {required this.companyLogo,
      required this.companyName,
      required this.jobLocation,
      required this.jobTitle,
      required this.jobSalaryRange,
      required this.jobDescription,
      required this.salaryRangeType,
      required this.jobType,
      required this.jobCategory,
      required this.jobRequirements,
      required this.requiredSkillsList});
}
