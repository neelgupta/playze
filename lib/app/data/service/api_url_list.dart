class ApiUrlList {
  //old base api url
  // static String baseUrl = "https://rkinfosolution.com/playze/api/";

  //main base api url
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
  static String forgotPassword = '${baseUrl}forgotPassword';
  static String userAddprofile = '${baseUrl}profile';
  static String categoryPlaceFilter = '${baseUrl}place-filter';
  static String searchFilter = '${baseUrl}search';
  static String addToWishlist = '${baseUrl}wishlist/addwishlist';
  static String getWishList = '${baseUrl}wishlist/wishlistget';

  //plan manage apis
  static String planDayGetlist = '${baseUrl}day/plandaylist';
  static String planGetlistByDay = '${baseUrl}planlist';
  static String addPlanToDay = '${baseUrl}addplan';
  static String dayAddToList = '${baseUrl}day/add';
  static String dayDeleteFromList = '${baseUrl}day/delete';
  static String planDeleteFromlist = '${baseUrl}plandelete';
  static String planDayChange = '${baseUrl}plandaychange';
  static String planDayReorder = '${baseUrl}plandayreorder';
  static String planStartTime = '${baseUrl}starttime';
  static String planDurationTime = '${baseUrl}durationtime';
}
