class Job {
    Job({
        this.id,
        this.imageUrl,
        this.jobTitle,
        this.companyId,
        this.salary,
        this.location,
    });

    int? id;
    String? imageUrl;
    String? jobTitle;
    int? companyId;
    String? salary;
    String? location;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        imageUrl: json["image_url"],
        jobTitle: json["job_title"],
        companyId: json["company_id"],
        salary: json["salary"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "job_title": jobTitle,
        "company_id": companyId,
        "salary": salary,
        "location": location,
    };
}