import 'package:the_staff_hound/helper/dialog_helper.dart';

import '../exceptions/api_exceptions.dart';

class BaseControler {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is ApiNotRespondingException) {

      DialogHelper.showErrorDialog(description: 'Oops! it took longer to respond.');
    }
  }
}
