// ignore_for_file: constant_identifier_names

part of 'constants.dart';

sealed class Urls {
  static const int PAGESIZE = 50;
  static const String PRODUCT_LISTING = "/api/appV1/product-listing";
  static const String CATEGORIES = "/api/appV1/categories";
  static const String HOME_BANNERS = "/api/appV1/home_banners";
  static const String TOP_BRANDS = "/api/appV1/top_brands";
  static const String TOP_SELLERS = "/api/appV1/top_sellers";
  static const String PROMOTIONS = "/api/appV1/promotions";
  static const String NEW_ARRIVALS = "/api/appV1/new_arrivals";
  static const String DAILY_DEALS = "/api/appV1/daily_deals";
  static const String TECHNICIAN = "/api/appV1/technicians";
  static const String AUCTION = "/api/appV1/auction_products";
  static const String FLASH_DEAL = "/api/appV1/flash_deal_end_date_api";
  static const String NEWS_BAR = "/api/appV1/news_bar";
  static const String PRODUCT_DETAIL = "/api/appV1/product-detail/";
  static const String ASK_QUESTIONS = "/api/appV1/product/add-new-question";
  static const String SUB_CATEGORIES = "/api/v2/sub-categories/265";
  static const String SUB_CATEGORIES_PRODUCT = "/api/v2/products/category/256";
  static const String ADD_TO_CART = "/api/appV1/addToCartBothSAndP";
  static const String VIEW_CART = "/api/appV1/view_cart";
  static const String CART_QUANTITY = "/api/appV1/updateQuantity";
  static const String DELETE_CART_PRODUCT = "/api/appV1/removeFromCart";
  static const String COUNTRIES = "/api/v2/countries";
  static const String ADD_NEW_ADDRESS = "/api/appV1/addNewAddress";
  static const String SEE_LOCATIONS = "/api/appV1/viewAddresses";
  static const String DELETE_LOCATION = "/api/v2/user/shipping/delete";
  static const String UPDATE_LOCATION = "/api/v2/user/shipping/update";
  static const String DELIVERY_INFO = "/api/appV1/delivery-info-api";
  static const String SEND_QUOTES = "/api/appV1/store_by_quote";
  static const String PAYMENT_SUCCESS = "/api/v2/stripe/success";
  static const String PLACE_ORDER = "/api/v2/order/store";
  static const String SEARCH_PRODUCT = "/api/appV1/search";
  static const String SEARCH_PRODUCT_UPDATE = "/api/appV1/ajax-search";

  static const String SHIPPING_COST = "/api/appV1/calculate_shipping_cost";
  static const String STORE = "/api/appV1/stores";
  static const String ADD_TO_WISHLIST = "/api/appV1/addProductWishlist";
  static const String VIEW_WISHLIST = "/api/appV1/viewWishlist";
  static const String DELETE_WISHLIST_ITEM = "/api/appV1/removeFromWishlist";
  static const String PURCHASE_HISTORY = "/api/appV1/purchase_history";
  static const String QUOTE_ORDERS = "/api/appV1/customer_quotes_orders";
  static const String SHIPPING_QUOTES = "/api/appV1/customer_shipping_quotes";
  static const String SHIPPING_ORDERS = "/api/appV1/customer_shipping_orders";
  static const String CONTACT_US = "/api/appV1/submit_contact";
  static const String SHIP_MOYEN = "/api/appV1/submit-quote";
  static const String SHIP_PRODUCTS = "/api/appV1/shipping_products";
  static const String SHIP_WITH_MOYEN = "/api/appV1/store_shipping_quote";
  static const String PLACE_BID = "/api/appV1/place_auction_product_bid";
  static const String PLACE_AUTO_BID =
      "/api/appV1/place_auction_product_auto_bid";
  static const String REGION_SELLER = "/api/appV1/regions";
  static const String REGION_SELLER_STORES = "/api/appV1/stores";
  static const String PAYMENT_SERVICES = "/api/appV1/select-service";
  static const String TRACK_SHIPMENT = "/api/appV1/ship-with-moyen-tracking";
  static const String INQUIRIES = "/api/appV1/inquires";
  static const String INQUIRY_DETAIL = "/api/appV1/inquiry_detail";
  static const String POST_NOTE = "/api/appV1/addInquiryNote";
  static const String QUOTATION_HISTORY = "/api/appV1/getQuotationHistory";
  static const String SEND_INQUIRY = "/api/appV1/send_inquiry_detail";
  static const String REFUND_REQUEST = "/api/appV1/sentrefundrequest";
  static const String WALLET = "/api/appV1/getWalletHistory";
  static const String WALLET_RECHARGE = "/api/appV1/walletrecharge";
  static const String WALLET_WITHDRAW = "/api/appV1/getWithdrawRequestHistory";
  static const String RECENTLY_VIEWS = "/api/appV1/getRecentViews";
  static const String CASHBACK_HISTORY = "/api/appV1/cashbackHistory";
  static const String GALLERY_DATA = "/api/appV1/allfiles";
  static const String POST_IMAGE = "/api/appV1/files-upload";
  static const String WITHDRAW_POST = "/api/appV1/sendwithdrawrequest";
  static const String BRANDS = '/api/appV1/get-brands';
  static const String COLORS = '/api/appV1/get-colors';
  static const String WHOLESALES_PRODUCTS = '/api/appV1/getWholesaleProducts';
  static const String NOTIFICATIONS = '/api/appV1/getNotifications';
  static const String PAYMENT_SERVICE = '/api/appV1/getNotifications';
  static const String CONVERSATION_SELLER = '/api/appV1/messageSeller';
  static const String STORE_CART_INFO = '/api/store_delivery_info';
// Auth
  static const String SIGN_UP = "/api/appV1/customer/signup";
  static const String VERIFY_OTP = "/api/appV1/verify_otp";
  static const String LOGIN = "/api/appV1/login";
  static const String DELETE_ACCOUNT = "/api/appV1/delete-account";
  static const String UPDATE_EMAIL = "/api/appV1/updateEmail";
}
