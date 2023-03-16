import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:the_staff_hound/constants.dart';

class ApiServices {
  static var client = http.Client();

  static Future<http.Response?> getSingleProjects(String token, int? id) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-projects');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'id': id.toString(),
        'filter_status': 'Open'
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getCategories(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-categories');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> applyJob(String token, int projectID) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}apply-job');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'project_id': projectID.toString(),
        'status': 'pending'
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getDashboardData(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}dashboard');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getAppliedJobs(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-applied-jobs');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getAssignedJobs(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-assigned-jobs');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getJobsByCategory(
      String token, int categoryID) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-categories-related-jobs');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'category_id': categoryID.toString()
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getMulitpleProjects(
    String token,
  ) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-jobs');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'filter_status': 'Open'
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> saveProject(
      String token, int jobId, int status) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}add-saved-job');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'project_id': jobId.toString(),
        'status': status.toString()
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getSavedProjects(
    String token,
  ) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-saved-jobs');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getJobOffers(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-offers');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getAnnouncements(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-notifications');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> updateNotificationStatus(
      String token, int id) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}update-notification');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'id': id.toString(),
        'status': 'seen'
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> respondToOffer(
      String token, int id, String status) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}respond-to-offer');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'status': status,
        'project_id': id.toString()
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> getOffersNotification(String token) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}get-notify-offers');

      http.Response response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> updateOffer(
      String token, String status, int id, int isSeen) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}update_offer');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'status': status,
        'id': id.toString(),
        'is_seen': isSeen.toString(),
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> acceptOfferConfirmation(
      String token, int id) async {
    try {
      var uri = Uri.parse('${Constants.baseUrl}accept-offer-confirmation');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'id': id.toString(),
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  static Future<http.Response?> acceptDirectApplyConfirmation(
      String token, int id) async {
    try {
      var uri =
          Uri.parse('${Constants.baseUrl}accept-direct-apply-confirmation');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json'
      }, body: {
        'id': id.toString(),
      }).timeout(const Duration(seconds: 30));
      return response;
    } on TimeoutException {
      Constants.showToast('Request timeout. Please try again later.');
      return null;
    }
  }
}
