class ApiUrlList {
  // static String baseUrl = "https://rkinfosolution.com/playze/api/";
  static String baseUrl = "https://aaradhyatoursandtravels.co.in/playze/api/";

  //auth apis
  static String register = '${baseUrl}registermobile';
  static String otp = '${baseUrl}otoverify';
  static String login = '${baseUrl}login';
  static String resendOtp = '${baseUrl}resendotp';
  static String addprofile = '${baseUrl}addprofile';

  //user apis
  static String contactUs = '${baseUrl}contact/addContact';
  static String userChangePassword = '${baseUrl}userchanegpassword/userupdate';

  //user active apis
  static String getinterest = '${baseUrl}interestActiveList';
  static String categoryList = '${baseUrl}usercategorylist';
  static String placesActiveList = '${baseUrl}placesActiveList';
  static String activeEmojisList = '${baseUrl}activeEmojisList';

  //userrdetails apis
  static String userDetailes = '${baseUrl}userDetailes';
  static String plaseDetails = '${baseUrl}plaseDetails';
  static String deleteChildren = '${baseUrl}deleteChildren';
  static String getWorkspace = '${baseUrl}workspace/getWorkspace';

  //details page apis
  static String nearbyPlaces = '${baseUrl}nearby-places';
  static String pleaseReview = '${baseUrl}pleasereview';

  ///user functions apis
  static String addWorkSpace = '${baseUrl}workspace/addWorkspace';
  static String addReview = '${baseUrl}addReview';

  //common apis
  static String aboutus = '${baseUrl}about';
  static String userAddprofile = '${baseUrl}profile';
  static String categoryPlaceFilter = '${baseUrl}place-filter';
  static String searchFilter = '${baseUrl}search';
}
