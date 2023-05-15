import 'package:get/get.dart';

import '../modules/Aboutus/bindings/aboutus_binding.dart';
import '../modules/Aboutus/views/aboutus_view.dart';
import '../modules/AddProfilePicture/bindings/add_profile_picture_binding.dart';
import '../modules/AddProfilePicture/views/add_profile_picture_view.dart';
import '../modules/BottomNavigationbar/bindings/bottom_navigationbar_binding.dart';
import '../modules/BottomNavigationbar/views/bottom_navigationbar_view.dart';
import '../modules/ChangePassword/bindings/change_password_binding.dart';
import '../modules/ChangePassword/views/change_password_view.dart';
import '../modules/ChooseProfilePicture/bindings/choose_profile_picture_binding.dart';
import '../modules/ChooseProfilePicture/views/choose_profile_picture_view.dart';
import '../modules/ContactUs/bindings/contact_us_binding.dart';
import '../modules/ContactUs/views/contact_us_view.dart';
import '../modules/Details/bindings/details_binding.dart';
import '../modules/Details/views/details_view.dart';
import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/Notifications/bindings/notifications_binding.dart';
import '../modules/Notifications/views/notifications_view.dart';
import '../modules/PlayzeWorkspace/bindings/playze_workspace_binding.dart';
import '../modules/PlayzeWorkspace/views/playze_workspace_view.dart';
import '../modules/ReviewImages/bindings/review_images_binding.dart';
import '../modules/ReviewImages/views/review_images_view.dart';
import '../modules/ReviewVideos/bindings/review_videos_binding.dart';
import '../modules/ReviewVideos/views/review_videos_view.dart';
import '../modules/Settings/bindings/settings_binding.dart';
import '../modules/Settings/views/settings_view.dart';
import '../modules/TermsConditions/bindings/terms_conditions_binding.dart';
import '../modules/TermsConditions/views/terms_conditions_view.dart';
import '../modules/Writeareview/bindings/writeareview_binding.dart';
import '../modules/Writeareview/views/writeareview_view.dart';
import '../modules/addplaces/bindings/addplaces_binding.dart';
import '../modules/addplaces/views/addplaces_view.dart';
import '../modules/childinfo/bindings/childinfo_binding.dart';
import '../modules/childinfo/views/childinfo_view.dart';
import '../modules/filter/bindings/filter_binding.dart';
import '../modules/filter/views/filter_view.dart';
import '../modules/fristpage/bindings/fristpage_binding.dart';
import '../modules/fristpage/views/fristpage_view.dart';
import '../modules/fullDetails/bindings/full_details_binding.dart';
import '../modules/fullDetails/views/full_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/myplan/bindings/myplan_binding.dart';
import '../modules/myplan/views/myplan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FRISTPAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.CHILDINFO,
      page: () => ChildinfoView(),
      binding: ChildinfoBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.FULL_DETAILS,
      page: () => const FullDetailsView(),
      binding: FullDetailsBinding(),
    ),
    GetPage(
      name: _Paths.WRITEAREVIEW,
      page: () => const WriteareviewView(),
      binding: WriteareviewBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.MYPLAN,
      page: () => MyplanView(),
      binding: MyplanBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATIONBAR,
      page: () => BottomNavigationbarView(),
      binding: BottomNavigationbarBinding(),
    ),
    GetPage(
      name: _Paths.ADDPLACES,
      page: () => const AddplacesView(),
      binding: AddplacesBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () =>  EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => AboutusView(),
      binding: AboutusBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => const TermsConditionsView(),
      binding: TermsConditionsBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.PLAYZE_WORKSPACE,
      page: () => PlayzeWorkspaceView(),
      binding: PlayzeWorkspaceBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROFILE_PICTURE,
      page: () => const AddProfilePictureView(),
      binding: AddProfilePictureBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_PROFILE_PICTURE,
      page: () => const ChooseProfilePictureView(),
      binding: ChooseProfilePictureBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_VIDEOS,
      page: () => const ReviewVideosView(),
      binding: ReviewVideosBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_IMAGES,
      page: () => const ReviewImagesView(),
      binding: ReviewImagesBinding(),
    ),
    GetPage(
      name: _Paths.FRISTPAGE,
      page: () => FristpageView(),
      binding: FristpageBinding(),
    ),
  ];
}
