import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view/cashback_history/cashback_history.dart';
import 'package:moyen_express/view/categories_products/categories_product.dart';
import 'package:moyen_express/view/check_out/checkout_view.dart';
import 'package:moyen_express/view/confirm_order/confirm_order_view.dart';
import 'package:moyen_express/view/confirm_order_payment/confirm_order_payment.dart';
import 'package:moyen_express/view/filters/filters_view.dart';
import 'package:moyen_express/view/gallery_search/gallery_search.dart';
import 'package:moyen_express/view/inquiries/inquiries_view.dart';
import 'package:moyen_express/view/inquiry_note/inquiry_notes.dart';
import 'package:moyen_express/view/mobile_payment/mobile_payment.dart';
import 'package:moyen_express/view/my_account/my_account.dart';
import 'package:moyen_express/view/my_quotes/quote_reply.dart';
import 'package:moyen_express/view/recently_view/recently_views.dart';
import 'package:moyen_express/view/region_seller/region_seller.dart';
import 'package:moyen_express/view/region_seller_store/region_seller_store.dart';
import 'package:moyen_express/view/send_inquiry/send_inquiry.dart';
import 'package:moyen_express/view/settings/setting_view.dart';
import 'package:moyen_express/view/shipping/parcel_detail.dart';
import 'package:moyen_express/view/sub_categories/component/child_categories.dart';
import 'package:moyen_express/view/technician/component/search_services.dart';
import 'package:moyen_express/view/technician/technician_detail.dart';
import 'package:moyen_express/view/track_ship/track_shipment.dart';
import 'package:moyen_express/view/wallet/wallet.dart';
import 'package:moyen_express/view/wire_transfer/wire_transfer.dart';
import 'package:moyen_express/view/withdraw_request/withdraw_request.dart';
import 'package:moyen_express/view/withdraw_request_history/withdraw_request_history.dart';
import 'package:moyen_express/view_model/bindings/cashback_history/cashback_history_binding.dart';
import 'package:moyen_express/view_model/bindings/child_category/child_category_binding.dart';
import 'package:moyen_express/view_model/bindings/confirm_order/confirm_order_binding.dart';
import 'package:moyen_express/view_model/bindings/inquiries/inquiries_binding.dart';
import 'package:moyen_express/view_model/bindings/mobile_payment/mobile_payment_binding.dart';
import 'package:moyen_express/view_model/bindings/region_seller_store/region_store_binding.dart';
import 'package:moyen_express/view_model/bindings/send_inquiry/send_inquiry_binding.dart';
import 'package:moyen_express/view_model/bindings/send_refund_request/send_refund_request_binding.dart';
import 'package:moyen_express/view_model/bindings/settings/settings_binding.dart';
import 'package:moyen_express/view_model/bindings/shipping_quotes/shipping_quotes_binding.dart';
import 'package:moyen_express/view_model/bindings/technician_detail/technician_detail_binding.dart';
import 'package:moyen_express/view_model/bindings/track_ship/track_shipment_binding.dart';
import 'package:moyen_express/view_model/bindings/wire_transfer/wire_transfer_binding.dart';
import '../../view/cash_payment/cash_payment.dart';
import '../../view/inquiry_detail/inquiry_detail.dart';
import '../../view/my_quotes/quotation_history.dart';
import '../../view/send_refund_request/send_refund_request.dart';
import '../../view/send_replace_request/send_replace_request.dart';
import '../../view/shipping_quote/shipping_quote_detail.dart';
import '../../view/shipping_quotes/shipping_quotes.dart';
import '../../view/wholesales_products/wholesales_product_view.dart';
import '../../view_model/bindings/all_products/all_products_binding.dart';
import '../../view_model/bindings/cash_payment/cash_payment_binding.dart';
import '../../view_model/bindings/filter_product/filter_product_binding.dart';
import '../../view_model/bindings/gallery_search/gallery_search_binding.dart';
import '../../view_model/bindings/inquiry_detail/inquiry_detail_binding.dart';
import '../../view_model/bindings/inquiry_note/inquiry_notes_binding.dart';
import '../../view_model/bindings/my_account/my_account_binding.dart';
import '../../view_model/bindings/my_quotes/quotation_history_binding.dart';
import '../../view_model/bindings/my_quotes_replies/quotation_replies_binding.dart';
import '../../view_model/bindings/new_arrivals/new_arrivals_binding.dart';
import '../../view_model/bindings/purchase_history_detail/purchase_history_binding.dart';
import '../../view_model/bindings/quote_detail/quote_detail_binding.dart';
import '../../view_model/bindings/recently_views/recently_views_binding.dart';
import '../../view_model/bindings/send_replace_request/send_replace_request_binding.dart';
import '../../view_model/bindings/shipping_description/shipping_description_binding.dart';
import '../../view_model/bindings/wallet/wallet_binding.dart';
import '../../view_model/bindings/wholesales/wholesale_binding.dart';
import '../../view_model/bindings/withdraw_request/withdraw_request_binding.dart';
import '../../view_model/bindings/withdraw_request_history/withdraw_request_history_binding.dart';

class Pages {
  static Transition get _routeTransition => Transition.rightToLeft;
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    switch (settings.name) {
      case Routes.OFFLINE:
        return GetPageRoute(
          settings: settings,
          page: () => const OfflineScreen(),
          transition: _routeTransition,
        );
      case Routes.ONBOARDING:
        return GetPageRoute(
          settings: settings,
          page: () => const OnBoarding(),
          binding: OnBoardingBinding(),
          transition: _routeTransition,
        );
      case Routes.DASHBOARD:
        return GetPageRoute(
          settings: settings,
          page: () => const Dashboard(),
          binding: DashboardBinding(),
          transition: _routeTransition,
        );
      case Routes.SIGN_IN:
        return GetPageRoute(
          settings: settings,
          page: () => const SignIn(),
          binding: SignInBinding(),
          transition: _routeTransition,
        );
      case Routes.SIGN_UP:
        return GetPageRoute(
          settings: settings,
          page: () => const SignUp(),
          binding: SignUpBinding(),
          transition: _routeTransition,
        );
      case Routes.HOME:
        return GetPageRoute(
          settings: settings,
          page: () => const Home(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.CATEGORIES:
        return GetPageRoute(
          settings: settings,
          page: () => const Categories(),
          binding: CategoriesBinding(),
          transition: _routeTransition,
        );
      case Routes.ALL_PRODUCTS:
        return GetPageRoute(
          settings: settings,
          page: () => const AllProducts(),
          binding: AllProductsBinding(),
          transition: _routeTransition,
        );
      case Routes.WHOLESALES_PRODUCTS:
        return GetPageRoute(
          settings: settings,
          page: () => const WholeSalesProducts(),
          binding: WholeSaleBinding(),
          transition: _routeTransition,
        );
      case Routes.DAILY_DEALS:
        return GetPageRoute(
          settings: settings,
          page: () => const DailyDeals(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.NEW_ARRIVALS:
        return GetPageRoute(
          settings: settings,
          page: () => const NewArrivals(),
          binding: NewArrivalsBinding(),
          transition: _routeTransition,
        );
      case Routes.PROMOTIONS:
        return GetPageRoute(
          settings: settings,
          page: () => const Promotions(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.TOP_SELLERS:
        return GetPageRoute(
          settings: settings,
          page: () => const TopSellers(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.TOP_BRANDS:
        return GetPageRoute(
          settings: settings,
          page: () => const TopBrands(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.FLASH_DEALS:
        return GetPageRoute(
          settings: settings,
          page: () => const FlashDeals(),
          binding: FlashDealsBinding(),
          transition: _routeTransition,
        );

      case Routes.PRODUCT_DETAILS:
        return GetPageRoute(
          settings: settings,
          page: () => const ProductsDetails(),
          binding: ProductDetailsBinding(),
          transition: _routeTransition,
        );
      case Routes.TECH_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const TechDetail(),
          binding: TechnicianDetailBinding(),
          transition: _routeTransition,
        );
      case Routes.CART:
        return GetPageRoute(
          settings: settings,
          page: () => const Cart(),
          binding: CartBinding(),
          transition: _routeTransition,
        );
      case Routes.LOCATIONS:
        return GetPageRoute(
          settings: settings,
          page: () => const Locations(),
          binding: LocationsBinding(),
          transition: _routeTransition,
        );
      case Routes.ADD_NEW_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const AddNewAddress(),
          binding: LocationsBinding(),
          transition: _routeTransition,
        );
      case Routes.ORDER_CONFIRMATION:
        return GetPageRoute(
          settings: settings,
          page: () => const OrderConfirmation(),
          binding: CartBinding(),
          transition: _routeTransition,
        );
      case Routes.NOTIFICATION:
        return GetPageRoute(
          settings: settings,
          page: () => const Notifications(),
          binding: NotificationBinding(),
          transition: _routeTransition,
        );
      case Routes.OTP_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const OtpScreen(),
          binding: OtpBinding(),
          transition: _routeTransition,
        );
      case Routes.PAYMENT_METHOD:
        return GetPageRoute(
          settings: settings,
          page: () => const PaymentMethod(),
          binding: PaymentMethodBinding(),
          transition: _routeTransition,
        );
      case Routes.AUCTION:
        return GetPageRoute(
          settings: settings,
          page: () => const Auction(),
          binding: AuctionBinding(),
          transition: _routeTransition,
        );
      case Routes.MXSHIPPING_VIEW:
        return GetPageRoute(
          settings: settings,
          page: () => const MoyenXpressShipping(),
          binding: MoyenXpressBinding(),
          transition: _routeTransition,
        );
      case Routes.TECHNICIAN_VIEW:
        return GetPageRoute(
          settings: settings,
          page: () => const TechnicianView(),
          binding: TechnicianBinding(),
          transition: _routeTransition,
        );
      case Routes.MY_ORDERS:
        return GetPageRoute(
          settings: settings,
          page: () => const MyOrdersView(),
          binding: MyOrdersBinding(),
          transition: _routeTransition,
        );
      case Routes.SHIPPING_ORDERS:
        return GetPageRoute(
          settings: settings,
          page: () => const ShippingOrdersView(),
          binding: MyOrdersBinding(),
          transition: _routeTransition,
        );
      case Routes.SHIPPING_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const ShippingDetailView(),
          binding: MyOrdersBinding(),
          transition: _routeTransition,
        );
      case Routes.QUOTE_ORDERS_CARD:
        return GetPageRoute(
          settings: settings,
          page: () => const QuoteOrderView(),
          // binding: MyOrdersBinding(),
          transition: _routeTransition,
        );
      case Routes.QUOTE_ORDERS_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const QuoteDetailView(),
          binding: QuoteDetailBinding(),
          transition: _routeTransition,
        );
      case Routes.SHIPPING_QUOTE_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const ShippingQuoteDetail(),
          binding: ShippingQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.CONTACT:
        return GetPageRoute(
          settings: settings,
          page: () => const ContactView(),
          binding: ContactBinding(),
          transition: _routeTransition,
        );
      case Routes.ABOUT:
        return GetPageRoute(
          settings: settings,
          page: () => const AboutView(),
          transition: _routeTransition,
        );
      case Routes.STORE:
        return GetPageRoute(
          settings: settings,
          page: () => const StoreView(),
          binding: StoreBinding(),
          transition: _routeTransition,
        );
      case Routes.STORE_HOME:
        return GetPageRoute(
          settings: settings,
          page: () => const StoreHomeView(),
          binding: StoreBinding(),
          transition: _routeTransition,
        );
      case Routes.GET_QUOTE:
        return GetPageRoute(
          settings: settings,
          page: () => const GetAQuote(),
          binding: GetQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.FROM_FORM_QUOTE:
        return GetPageRoute(
          settings: settings,
          page: () => const FromForm(),
          binding: GetQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.TO_FROM_QUOTE:
        return GetPageRoute(
          settings: settings,
          page: () => const ToForm(),
          binding: GetQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.SHIPMENT_DESCRIPTION:
        return GetPageRoute(
          settings: settings,
          page: () => const ShipmentDescription(),
          binding: ShippingDescriptionBinding(),
          transition: _routeTransition,
        );
      case Routes.PARCEL_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const ParcelDetail(),
          binding: GetQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.PURCHASE_HISTORY:
        return GetPageRoute(
          settings: settings,
          page: () => const PurchaseHistory(),
          binding: PurchasingHistoryBinding(),
          transition: _routeTransition,
        );
      case Routes.PURCHASE_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const PurchasingDetail(),
          binding: PurchaseHistoryDetailBinding(),
          transition: _routeTransition,
        );
      case Routes.REFUND_REQUEST:
        return GetPageRoute(
          settings: settings,
          page: () => const RefundRequest(),
          binding: RefundRequestBinding(),
          transition: _routeTransition,
        );
      case Routes.SPLASH_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const SplashView(),
          binding: SplashBinding(),
          transition: _routeTransition,
        );
      case Routes.WISHLIST:
        return GetPageRoute(
          settings: settings,
          page: () => const WishListView(),
          binding: WishListBinding(),
          transition: _routeTransition,
        );
      case Routes.PROFILE_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
          transition: _routeTransition,
        );
      case Routes.SEARCH_PRODUCT:
        return GetPageRoute(
          settings: settings,
          page: () => const SearchProduct(),
          binding: SearchProductBinding(),
          transition: _routeTransition,
        );
      case Routes.POLYGON_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const PolygonWidget(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.COMING_SOON_SCREEN:
        return GetPageRoute(
          settings: settings,
          page: () => const ComingSoonView(),
          transition: _routeTransition,
        );
      case Routes.SUB_CATEGORIES:
        return GetPageRoute(
          settings: settings,
          page: () => const SubCategories(),
          binding: SubCategoryBinding(),
          transition: _routeTransition,
        );
      case Routes.CHILD_CATEGORY:
        return GetPageRoute(
          settings: settings,
          page: () => const ChildCategory(),
          binding: ChildCategoryBinding(),
          transition: _routeTransition,
        );
      case Routes.CATEGORIES_PRODUCT:
        return GetPageRoute(
          settings: settings,
          page: () => const CategoriesProduct(),
          binding: SubCategoryBinding(),
          transition: _routeTransition,
        );
      case Routes.LOCATION_CARD:
        return GetPageRoute(
          settings: settings,
          page: () => const LocationCard(),
          binding: LocationsBinding(),
          transition: _routeTransition,
        );
      case Routes.CHECKOUT_VIEW:
        return GetPageRoute(
          settings: settings,
          page: () => const CheckOutView(),
          // binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.CONFIRM_VIEW:
        return GetPageRoute(
          settings: settings,
          page: () => const ConfirmOrderView(),
          binding: ConfirmOrderBinding(),
          transition: _routeTransition,
        );
      case Routes.SEARCH_SERVICES:
        return GetPageRoute(
          settings: settings,
          page: () => const SearchServices(),
          binding: TechnicianBinding(),
          transition: _routeTransition,
        );
      case Routes.SETTINGS:
        return GetPageRoute(
          settings: settings,
          page: () => const Settings(),
          binding: SettingBinding(),
          transition: _routeTransition,
        );
      case Routes.SHIPPING_QUOTE:
        return GetPageRoute(
          settings: settings,
          page: () => const ShippingQuotes(),
          binding: ShippingQuoteBinding(),
          transition: _routeTransition,
        );
      case Routes.REGION_SELLER:
        return GetPageRoute(
          settings: settings,
          page: () => const HomeRegionSeller(),
          transition: _routeTransition,
        );
      case Routes.REGION_SELLER_STORE:
        return GetPageRoute(
          settings: settings,
          page: () => const RegionSellerStores(),
          binding: RegionSellerBinding(),
          transition: _routeTransition,
        );
      case Routes.WIRE_TRANSFER:
        return GetPageRoute(
          settings: settings,
          page: () => const WireTransfer(),
          binding: WireTransferBinding(),
          transition: _routeTransition,
        );
      case Routes.MOBILE_PAYMENT:
        return GetPageRoute(
          settings: settings,
          page: () => const MobilePayment(),
          binding: MobilePaymentBinding(),
          transition: _routeTransition,
        );
      case Routes.CASH_PAYMENT:
        return GetPageRoute(
          settings: settings,
          page: () => const CashPayment(),
          binding: CashPaymentBinding(),
          transition: _routeTransition,
        );
      case Routes.MY_ACCOUNT:
        return GetPageRoute(
          settings: settings,
          page: () => const MyAccount(),
          binding: MyAccountBinding(),
          transition: _routeTransition,
        );
      case Routes.TRACK_SHIPPING:
        return GetPageRoute(
          settings: settings,
          page: () => const TrackShipping(),
          binding: TrackShippingBinding(),
          transition: _routeTransition,
        );
      case Routes.INQUIRIES:
        return GetPageRoute(
          settings: settings,
          page: () => const InquiriesView(),
          binding: InquiriesBinding(),
          transition: _routeTransition,
        );
      case Routes.INQUIRY_NOTES:
        return GetPageRoute(
          settings: settings,
          page: () => const InquiryNotes(),
          binding: InquiryNotesBinding(),
          transition: _routeTransition,
        );
      case Routes.INQUIRY_DETAIL:
        return GetPageRoute(
          settings: settings,
          page: () => const InquiryDetail(),
          binding: InquiryDetailBinding(),
          transition: _routeTransition,
        );
      case Routes.SEND_INQUIRY:
        return GetPageRoute(
          settings: settings,
          page: () => const SendInquiry(),
          binding: SendInquiryBinding(),
          transition: _routeTransition,
        );
      case Routes.QUOTATION_HISTORY:
        return GetPageRoute(
          settings: settings,
          page: () => const QuotationHistoryView(),
          binding: QuotationHistoryBinding(),
          transition: _routeTransition,
        );
      case Routes.QUOTATION_REPLIES:
        return GetPageRoute(
          settings: settings,
          page: () => const QuoteReplies(),
          binding: QuoteRepliesBinding(),
          transition: _routeTransition,
        );
      case Routes.SEND_REQUEST_REFUND:
        return GetPageRoute(
          settings: settings,
          page: () => const SendRefundRequest(),
          binding: SendRefundRequestBinding(),
          transition: _routeTransition,
        );
      case Routes.SEND_REQUEST_REPLACE:
        return GetPageRoute(
          settings: settings,
          page: () => const SendReplaceRequest(),
          binding: SendReplaceRequestBinding(),
          transition: _routeTransition,
        );
      case Routes.WALLET:
        return GetPageRoute(
          settings: settings,
          page: () => const WalletView(),
          binding: WalletBinding(),
          transition: _routeTransition,
        );
      case Routes.WITHDRAW_REQUEST:
        return GetPageRoute(
          settings: settings,
          page: () => const WithDrawRequest(),
          binding: WithdrawBinding(),
          transition: _routeTransition,
        );
      case Routes.RECENTLY_VIEWS:
        return GetPageRoute(
          settings: settings,
          page: () => const RecentlyViews(),
          binding: RecentlyViewsBinding(),
          transition: _routeTransition,
        );
      case Routes.CASHBACK_HISTORY:
        return GetPageRoute(
          settings: settings,
          page: () => const CashBackHistory(),
          binding: CashBackHistoryBinding(),
          transition: _routeTransition,
        );
      case Routes.GALLERY_SEARCH:
        return GetPageRoute(
          settings: settings,
          page: () => const GallerySearch(),
          binding: GalleryBinding(),
          transition: _routeTransition,
        );
      case Routes.WITHDRAW_REQUEST_HISTORY:
        return GetPageRoute(
          settings: settings,
          page: () => const WithDrawRequestHistory(),
          binding: WithDrawRequestBinding(),
          transition: _routeTransition,
        );
      case Routes.FILTERS_UI:
        return GetPageRoute(
          settings: settings,
          page: () => const FiltersView(),
          binding: FilterProductBinding(),
          transition: _routeTransition,
        );
      case Routes.CONFIRM_ID:
        return GetPageRoute(
          settings: settings,
          page: () => const ConfirmOrderPaymentView(),
          binding: ConfirmOrderBinding(),
          transition: _routeTransition,
        );

      default:
        return null;
    }
  }
}
