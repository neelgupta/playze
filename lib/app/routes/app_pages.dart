import 'package:get/get.dart';
import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/add_places/bindings/add_places_binding.dart';
import '../modules/add_profile_picture/bindings/add_profile_picture_binding.dart';
import '../modules/add_profile_picture/views/add_profile_picture_view.dart';
import '../modules/bottom_navigation_bar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/child_info/bindings/child_info_binding.dart';
import '../modules/choose_profile_picture/bindings/choose_profile_picture_binding.dart';
import '../modules/choose_profile_picture/views/choose_profile_picture_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/first_page/bindings/first_page_binding.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/place_full_details/bindings/place_full_details_binding.dart';
import '../modules/place_full_details/views/place_full_details_view.dart';
import '../modules/playze_workspace/bindings/playze_workspace_binding.dart';
import '../modules/playze_workspace/views/playze_workspace_view.dart';
import '../modules/review_images/bindings/review_images_binding.dart';
import '../modules/review_images/views/review_images_view.dart';
import '../modules/review_videos/bindings/review_videos_binding.dart';
import '../modules/review_videos/views/review_videos_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/terms_conditions/bindings/terms_conditions_binding.dart';
import '../modules/terms_conditions/views/terms_conditions_view.dart';
import '../modules/write_review/bindings/write_review_binding.dart';
import '../modules/write_review/views/write_review_view.dart';
import '../modules/add_places/views/add_places_view.dart';
import '../modules/child_info/views/childinfo_view.dart';
import '../modules/filter/bindings/filter_binding.dart';
import '../modules/filter/views/filter_view.dart';
import '../modules/first_page/views/first_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/myplan/bindings/myplan_binding.dart';
import '../modules/myplan/views/myplan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.FIRSTPAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.CHILDINFO,
      page: () => const ChildinfoView(),
      binding: ChildInfoBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => const FilterView(),
      binding: FilterBinding(),
    ),
    // GetPage(
    //   name: _Paths.DETAILS,
    //   page: () => const DetailsView(),
    //   binding: DetailsBinding(),
    // ),
    GetPage(
      name: _Paths.FULL_DETAILS,
      page: () => const PlaceFullDetailsView(),
      binding: PlaceFullDetailsBinding(),
    ),
    GetPage(
      name: _Paths.WRITEAREVIEW,
      page: () => const WriteareviewView(),
      binding: WriteReviewBinding(),
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
      binding: BottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.ADDPLACES,
      page: () => const AddplacesView(),
      binding: AddPlacesBinding(),
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
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => AboutusView(),
      binding: AboutUsBinding(),
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
      name: _Paths.FIRSTPAGE,
      page: () => FristpageView(),
      binding: FirstPageBinding(),
    ),
    // GetPage(
    //   name: _Paths.WORK,
    //   page: () => const WorkView(),
    //   binding: WorkBinding(),
    // ),
  ];
}
