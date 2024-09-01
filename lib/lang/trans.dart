import 'package:get/get.dart';
import 'package:moyen_express/resources/constants/constants.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Common
          Strings.NEXT: 'Next',
          Strings.PREVIOUS: 'Previous',
          Strings.SKIP: 'Skip',
          Strings.QUESTION: 'Question',
          // Paginated List View
          Strings.ADD_TO_CART: "Add To Cart",
          Strings.ADDED_TO_CART: "Added To Cart!",
          Strings.GO_TO_CART: "Go To Cart",
          Strings.CONTINUE_SHOPPING_BTN: "Continue\nShopping",
          Strings.ADD_TO_CHECKOUT: "Add To Checkout",
          Strings.ENTER_QUANTITY: "Enter Quantity",
          Strings.PLACE: "Place / Places",
          // Authentication
          Strings.SECURED_LOGIN: "SECURED LOGIN",
          Strings.REGISTER_ACCOUNT: "REGISTER ACCOUNT",
          Strings.RESET_PASSWORD: "RESET PASSWORD",
          Strings.WELCOME_BACK_TO: "Welcome Back To",
          Strings.MOYENXPRESS: "Moyenxpress",
          Strings.EMAIL: "Email",
          Strings.PASSWORD: "Password",
          Strings.CONFIRM_PASSWORD: "Confirm Password",
          Strings.FORGOT_PASSWORD: "Forgot Password ?",
          Strings.SIGN_IN: "Sign in",
          Strings.SIGN_UP: "Sign up",
          Strings.NAME: "Name",
          Strings.DO_NOT_HAVE_AN_ACCOUNT: "Don't have an account ?",
          Strings.LOGIN_SUBTITLE: "please login to your existing account.",
          Strings.LETS_GET: "Let's Get",
          Strings.STARTED: "Started",
          Strings.SEND_INQUIRY: "Send Inquiry",
          Strings.SIGN_UP_SUBTITLE:
              "create your account to moyenxpress and access to all our amazing features.",
          // Dashboard
          Strings.HOME: "Home",
          Strings.PRICE: "Price",
          Strings.CATEGORIES: "Categories",
          Strings.CART: "Cart",
          Strings.NOTIFICATION: "Notification",
          Strings.STORES: "Stores",
          Strings.SHOP: "Shop",
          Strings.ABOUT: "About",
          Strings.CONTACT: "Contact",
          Strings.SHIPPING: "Shipping",
          Strings.TECHNICIAN: "Technician",
          Strings.MOYENXPRESS_SHIPPING: "Moyenxpress Shipping",
          Strings.REGIONS_SELLERS: "Regions Sellers",
          Strings.AUCTIONS: "Auctions",
          Strings.MY_ORDERS: "My Orders",
          Strings.SHIP_WITH_MOYEN: "Ship With Moyen",
          Strings.SERVICE_WITH_MOYEN: "Book Top Technician Services Today",
          Strings.CONTINUE: "Continue",
          //Home
          Strings.SPORTS_OUTDOOR: "Sports & Outdoor",
          Strings.SEE_ALL: "See All",
          Strings.ALL_PRODUCTS: "All Products",
          Strings.FEATURES_PRODUCT: "Features Products",
          Strings.SOMETHING_WENT_WRONG: "Something went wrong",
          Strings.CONTENT_NOT_FOUND: "Content Not Found !!",
          Strings.NO_ITEMS_FOUND: "No Items found",
          Strings.DAILY_DEALS: "Daily Deals",
          Strings.NEW_ARRIVALS: "New Arrivals",
          Strings.FREE_SHIPPING: "FREE SHIPPING / FREE RETURN",
          Strings.DESC: "For all orders over 9\$",
          Strings.PROMOTIONS: "Promotions",
          Strings.TOP_SELLERS: "Top Sellers",
          Strings.TOP_BRANDS: "Top Brands",
          Strings.VIEW_SHOP: "View Shop",
          Strings.VIEW: "View",
          Strings.FLASH_DEALS: "Flash Deals",
          Strings.UP_TO: "Up to",
          Strings.OFF: "Off",
          Strings.SHIPCARD_HEAD1: "Ship with Moyen Xpress",
          Strings.SHIPCARD_DESC1:
              "Use Moyen Xpress as your shipping target & get exclusive discounts.",
          Strings.SHIPCARD_HEAD2: "Send Anything, Anywhere",
          Strings.SHIPCARD_DESC2:
              "Use Moyen Xpress shipping & send anything, anywhere in the world.",
          Strings.MX_SHIPPING: "One Request, Multiple Quotes",
          Strings.MX_SHIPPING_DISC:
              "Describe your need, send a quote and get multiple replies from the wide range of suppliers",

          // Product Details
          Strings.PRODUCT_DETAILS: "Product Details",
          Strings.PRODUCTS: "Products",
          Strings.PRODUCT: "Product",
          Strings.CHILD_CATEGORIES: "Child Categories",
          Strings.TECH_PRODUCT_DETAILS: "Technician Details",
          Strings.DAYS: "Days",
          Strings.REVIEWS: "Reviews",
          Strings.CHAT_WITH_SELLER: "Chat With Seller",
          Strings.DESCRIPTION: "Description",
          Strings.REVIEWS_RATING: "Reviews & Rating",
          Strings.CUSTOMER_Q_A: "Customer Q&A",
          Strings.READ_MORE: "Read More",
          Strings.READ_LESS: "Read Less",
          Strings.DISCOUNT_PRICE: "Discount Price:",
          Strings.PIECES: "Pieces",
          Strings.BUY_NOW: "Buy Now",
          Strings.Item_Added_To_Your_Cart: "Item Added To Your Cart!",
          Strings.BACK_TO_SHOPPING: "Back To Shopping",
          Strings.MY_CART: "My Cart",
          Strings.PIECE: "Piece",
          Strings.QUOTE: "Quote",
          Strings.CAN_NOT_ORDER: "You can not order this product",
          Strings.ORDER_CONFIRMATION: "Order Confirmation",
          Strings.UNIT_PRICE: "Unit Price",

          // Locations
          Strings.MY_ADDRESS: "My Address",
          Strings.MY_LOCATIONS: "My Locations",
          Strings.ADDRESS: "Address",
          Strings.COMPLETE_ADDRESS: "Complete Address",
          Strings.POSTAL_CODE: "Postal Code",
          Strings.CITY: "City",
          Strings.STATE: "State",
          Strings.PHONE: "Phone",
          Strings.ADD_NEW_ADDRESS: "Add New Address",
          Strings.EDIT_ADDRESS: "Edit Address",
          Strings.CHANGE_ADDRESS: "Change Address",
          Strings.CITY_IS_REQUIRED: "City is required",
          Strings.SELECT_CITY: "Select City",
          Strings.COUNTRY_IS_REQUIRED: "Country is required",
          Strings.COUNTRY: "Country",
          Strings.SELECT_COUNTRY: "Select Country",
          Strings.STATE_IS_REQUIRED: "State is required",
          Strings.SELECT_STATE: "Select State",
          Strings.FILL_BELOW_FIELDS:
              "Fill all the below fields to add new address",
          Strings.FILL_BELOW_FIELDS_EDIT:
              "Fill all the below fields to edit address",
          Strings.SAVE: "Save",

          // Notifications
          Strings.NOTIFICATIONS: "Notifications",
          Strings.PURCHASE_NOW: "Purchase Now",
          Strings.REFUNDABLE: "Refundable:",

          // Otp
          Strings.ENTER_OTP: "Enter Otp",
          Strings.VERIFY: "Verify",
          Strings.VERIFY_EMAIL: "Verify Email",

          // Payment Method
          Strings.PAYMENT_METHOD: "Payment Method",
          Strings.PLACE_ORDER: "Place Order",
          Strings.ORDER_OVERVIEW: "Order Overview",
          Strings.SEND: "Send",
          Strings.THANK_YOU: "Thank You For Your Order!",
          Strings.THE_ORDER: "The Order Confirmation Has Been"
              "Sent To Your Email Address.",
          Strings.TOTAL_AMOUNT: "Total Amount",
          Strings.ITEMS_ORDER: "Items Order",
          Strings.EST_DELIVERY: "Est. Delivery",
          Strings.CONTINUE_SHOPPING: "Continue Shopping",

          // Auction
          Strings.NOTE: "Note",
          Strings.PRODUCT_INFO: "Product Info",
          Strings.AUCTION_PRODUCT_DETAILS: "Auction Product Details",
          Strings.AUCTION_WILL_END: "Auction Will End",
          Strings.AUTO_BID: "Auto Bid",
          Strings.START_BIDING: "Start Biding",
          Strings.BID_FOR_PRODUCT: "Bid For Product",
          Strings.MIN_BID_AMOUNT: "Min Bid Amount",
          Strings.BID_AMOUNT: "Bid Amount",
          Strings.SUBMIT: "Submit",
          Strings.START_BID_AMOUNT: "Start Bid Amount",
          Strings.INCREMENT_PER_BID: "Increment Per Bid",
          Strings.MAXIMUM_BID_AMOUNT: "Maximum Bid Amount",

          //Technician
          Strings.SELECT_AREA: "Select Your Area",

          //my_orders
          Strings.SHIPPING_ORDER: "Shipping Orders",
          Strings.QUOTES_ORDER: "quote orders",
          Strings.SHIPPING_QUOTES: "Shipping quotes",

          //Shipping Orders
          Strings.RE_ORDER: "Re-order",

          //Quote Orders
          Strings.SHIPMENT_DETAILS: "Shipment Details",
          Strings.PKG_DESCRIPTION: "Package Description",
          Strings.SHIP_COST_DETAIL: "Shipment Cost Details ",

          //contact
          Strings.ASK_ANYTHING: "Ask Anything",
          Strings.PHONE_NUMBER: "Phone Number",
          Strings.MESSAGE: "Message",

          //about
          Strings.HEAD1_ABOUT: "Shop Anything & Make Your Life Easy.",
          Strings.DESC_ABOUT:
              "Moyen Xpress makes your life easy, with one touch of a button you can buy anything from anywhere throw Moyen Xpress and get a top notch quality of the product. We also have lots of variety of services that has been listed for customers accessibility and ease.",
          Strings.DESC1_ABOUT:
              "Moyen Xpress is on the verge to become the worlds largest E-Commerce store and will make sure that it's members get satisfied and make their life easier.",
          Strings.HEAD2_ABOUT: "How We Become A Huge Family.",
          Strings.DESC2_ABOUT:
              "From anywhere throw Moyen Xpress and get a top notch quality of the product. We also have lots of variety of services that has been listed for customers accessibility and ease.",
          // ignore: equal_keys_in_map
          Strings.DESC3_ABOUT:
              "Moyen Xpress is on the verge to become the worlds largest E-Commerce store and will make sure that it's members get satisfied and make their life easier.",

          //store
          Strings.STORE_HOME: "Store Home",
          Strings.STORE: "Store",
          Strings.ADDRESS_STORE:
              "1565 Woodington Circle, Lawrenceville, GA, USA",
          Strings.TOP_SELLING: "Top Selling",
          // //Get_A_Quote
          Strings.GET_A_QUOTE: "Get A Quote",
          Strings.SHIPMENT_FORM: "Shipment Form",
          Strings.NEW_MEMBER: "New Customer",
          Strings.MOYEN_XPRESS_MEMBER: "Moyen Xpress Member",
          Strings.DOCUMENTS: "Documents",
          Strings.PARCELS: "Parcels",
          Strings.DOMESTIC: "Domestic",
          Strings.INTERNATIONAL: "International",
          Strings.AIR_FREIGHT: "Air Freight",
          Strings.OCEAN_FREIGHT: "Ocean Freight",
          Strings.BY_ROAD: "By Road",
          Strings.FULL_NAME: "Full Name",
          Strings.FROM: "From:",
          Strings.To: "To:",
          Strings.CSC: "Country, State, City",
          Strings.BUSINESS_EMAIL: "Business Email (Optional)",
          Strings.BUSINESS_EMAIL_DESC: "Enter your business email",
          Strings.BUSINESS_PHONE_NO: "Business Phone Number (Optional)",
          Strings.BUSINESS_PHONE_NO_DESC: "Enter your business phone number",
          Strings.ADDRESS1: "Address 1",
          Strings.ADDRESS2: "Address 2 (Optional)",
          Strings.SHIPMENT_DESCRIPTION: "Shipment Description:",
          Strings.SHIPPING_PRODUCTS: "Shipping Products:",
          Strings.PRODUCT_NAME: "Product Name",
          Strings.WEIGHT: "weight (KG)",
          Strings.LENGTH: "length (CM)",
          Strings.WIDTH: "Width (CM)",
          Strings.HEIGHT: "Height (CM)",
          Strings.QUANTITY: "Quantity",
          Strings.WHAT_IN_THE_BOX: "Describe! what in the box?",
          Strings.VALUE_OF_PARCEL: "Value Of Parcel (CFA)",
          Strings.SET_PICKUP_DATE: "Set Pickup date",

          //Purchase History
          Strings.PURCHASE_HISTORY: "Purchase History",
          Strings.REFUND: "Refund",
          Strings.REFUND_DESC: "Refund Availability 3 days ",

          //Refund Request
          Strings.REFUND_REQUEST: "Refund Request",
          Strings.ORDER_CODE: "Order Code",
          Strings.QUANTITY_TYPE: "Quantity Type",
          Strings.REFUND_TYPE: "Refund Type",
          Strings.RETURN_TYPE: "Return Type",
          Strings.REFUND_REASON: "Refund Reason",
          Strings.DROP_OFF_ADDRESS: "Drop Off Warehouse Address",
          Strings.DROP_OFF_STATUS: "Drop Off Status",
          Strings.PRODUCT_IMAGE: "Product Image",
          Strings.RETURN_COST: "Total Refund Cost \$10.00",
          Strings.UPLOAD: "Upload",
          Strings.NOTE_REFUND:
              "There will be 10% Restocking fee on all the Product Refunds.",

          //WishList
          Strings.WISHLIST: "Wishlist",

          //Profile
          Strings.PROFILE: "Profile",
          Strings.SIGN_OUT: "Sign Out",
          Strings.OLD_PASSWORD: "Old Password",
          Strings.NEW_PASSWORD: "New Password",
          Strings.CHANGE_YOUR_EMAIL: "Change Your Email",
          Strings.UPDATE_PROFILE: "Update Profile",

          //Search
          Strings.SEARCH_PRODUCT: "Search Product",
          Strings.ALL_SERVICES: "All Services",
          Strings.SEARCH: "Search ",

          //CheckOut
          Strings.CHECK_OUT: "Check Out",
          Strings.DELIVERY_INFO: "Continue to Delivery Info",

          //Payment Method
          Strings.ESCROW: "Escrow",
          Strings.ESCROW_DESCRIPTION:
              "If You Check the Escrow Checkbox. Vendor Will Receive Payment After Your Delivery. ",
          Strings.ADDITIONAL_INFO: "Any Additional Info?",
          Strings.SEND_QUOTE: "Send Quote",

          //payment Method
          Strings.CARD_PAYMENT: "Card Payment",
          Strings.CARD_HOLDER_NAME: "Card Holder Name",
          Strings.CARD_NUMBER: "Card Number",
          Strings.EXP_MONTH: "Expiry Month",
          Strings.EXP_YEAR: "Expiry Year",
          Strings.CARD_CVC: "Card Cvc",
          Strings.COMPLETED_ORDER: "Complete Order",
          Strings.SELECT_PAYMENT_TYPE: "Select Payment Type:",
          Strings.SUMMARY: "Summary:",
          Strings.TOTAL: "Total",
          Strings.SUB_TOTAL: "Sub Total",
          Strings.SERVICE_NAME: "Service Name",
          Strings.TAX: "Tax",
          Strings.TOTAL_SHIPPING: "Total Shipping",
          Strings.AVAILABLE: "Available",
          Strings.NOT_AVAILABLE: "Not Available",
          Strings.DELIVERY_ADDRESS: "Delivery Address",
          Strings.REQUEST_QUOTE: "REQUEST FOR QUOTATION",
          Strings.DOWNLOAD_INVOKE: "DOWNLOAD_INVOKE",

          Strings.SELLER: "Seller",
          Strings.PAYMENT_STATUS: "Payment Status",
          Strings.DELIVERY_STATUS: "Delivery Status",
          Strings.SHIPPING_ADDRESS: "Shipping Address",
          Strings.EMAIL_ADDRESS: "Email Address",
          Strings.PURCHASE_DATE: "Purchase Date",
          Strings.PURCHASE_ID: "Purchase Id",

          Strings.QUOTE_DETAIL: "Quote Details: ",
          Strings.QUOTE_SUMMARY: "Quote Summary: ",
          Strings.CUSTOMER_NAME: "Customer Name: ",
          Strings.SELLER_NAME: "Seller Name: ",
          Strings.CUSTOMER_EMAIL: "Customer Email: ",
          Strings.ORDER_ID: "Order Id: ",
          Strings.ORDER_DATE: "Order Date: ",
          Strings.ORDER_STATUS: "Order Status: ",
          Strings.QUOTE_AMOUNT: "Quote Amount: ",
          Strings.QUOTE_ID: "Quote Id: ",
          Strings.SHIPMENT_DATE: "Shipment Date: ",
          Strings.SHIPMENT_FROM: "Shipment From: ",
          Strings.SHIPMENT_TO: "Shipment To: ",
          Strings.SHIPMENT_VIA: "Shipment Via: ",
          Strings.ADMIN_APPROVAL: "Admin Approval: ",
          Strings.QUOTE_ORDER_DETAIL: "Quote Order Detail",
          Strings.ADDRESS_2: "Address 2",
          Strings.PACKAGE_DESCRIPTION: "Package Description:",
          Strings.BOX_SIZE: "Box Size",
          Strings.PICKUP_DATE: "Pickup date",
          Strings.SHIPPING_fROM: "Shipping From: ",
          Strings.SHIPPING_TO: "Shipping To: ",
          Strings.SHIPPING_DATE: "Shipping Date: ",
          Strings.DOWNLOAD_INVOICE: "Download Invoice",

          Strings.PLACE_: "Piece/Pieces ",
          Strings.BAGS: "Bag/Bags ",
          Strings.DOZEN: "Dozen/Dozens ",
          Strings.GALLON: "Gallon/Gallons ",
          Strings.GRAM: "Gram/Grams ",
          Strings.KILO: "Kilogram/Kilograms ",
          Strings.METER: "Meter/Meters ",
          Strings.OUT_OF_STOCK: "Out of Stock",
          Strings.SIZE: "Size",
          Strings.PLACE_BID: "Place Bid",

          Strings.STARTING_BIDING: "Starting Bid:",
          Strings.MY_BIDDING_AMOUNT: "My Bidded Amount:",
          Strings.PRODUCT_CONDITION: "Product Condition:",
          Strings.VEHICLE_CONDITION: "Vehicle Condition:",
          Strings.HIGHEST_BID: "Highest Bid:",
          Strings.ORDER_CONFIRMED: "You Order is Confirmed",
          Strings.ORDER_SUMMARY:
              "A copy or your order summary has been sent to",
          Strings.SUMMARY_ORDER: "Order Summary",
          Strings.PICKUP_ADDRESS: "Pickup Address",
          Strings.ORDER_DETAIL: "Order Detail",
          Strings.VARIATION: "Variation",
          Strings.DELIVERY_TYPE: "Delivery Type",
          Strings.SEARCH_NOW: "Search Now",
          Strings.I_AM_SHOPPING_FOR: "I am Shopping for...  ",
          Strings.SETTING: "Setting",
          Strings.WHOLESALERS: 'Wholesale Products',
          Strings.TECHNICIANS: "Technicians",
          

        },
        "fr_FR": {
          Strings.WHOLESALERS: 'Produits en gros',
          Strings.REQUEST_QUOTE: "Demende De Devis",
          Strings.DOWNLOAD_INVOKE: "Télécharger Invoquer",

          Strings.NEXT: 'Suivant',
          Strings.PREVIOUS: 'Précédent',
          Strings.SKIP: 'Sauter',
          Strings.QUESTION: 'Question',
          // Paginated List View
          Strings.ADD_TO_CART: "Ajouter au panier",
          Strings.ADD_TO_CHECKOUT: "Ajouter à la caisse",
          //
          Strings.SECURED_LOGIN: "CONNEXION SÉCURISÉE",
          Strings.REGISTER_ACCOUNT: "CRÉER UN COMPTE",
          Strings.RESET_PASSWORD: "RÉINITIALISER LE MOT DE PASSE",
          Strings.WELCOME_BACK_TO: "Bon retour à",
          Strings.MOYENXPRESS: "Moyenxpress",
          Strings.EMAIL: "E-mail",
          Strings.PASSWORD: "Mot de passe",
          Strings.CONFIRM_PASSWORD: "Confirmez le mot de passe",
          Strings.FORGOT_PASSWORD: "Mot de passe oublié ?",
          Strings.SIGN_IN: "Connexe",
          Strings.SIGN_UP: "S'inscrire",
          Strings.NAME: "Nom",
          Strings.DO_NOT_HAVE_AN_ACCOUNT: "Je n'ai pas de compte ?",
          Strings.LOGIN_SUBTITLE:
              "veuillez vous connecter à votre compte existant.",
          Strings.LETS_GET: "Obtenons",
          Strings.STARTED: "Commencé",
          Strings.SEND_INQUIRY: "envoyer une demande",
          Strings.SIGN_UP_SUBTITLE:
              "créez votre compte sur moyenxpress et accédez à toutes nos fonctionnalités étonnantes.",
          Strings.ENTER_QUANTITY: "Entrez la quantité (facultatif)",
          Strings.PLACE: "Lieu / Lieux",
          // Dashboard
          Strings.HOME: "Maison",
          Strings.PRICE: "Prix",
          Strings.CATEGORIES: "Catégories",
          Strings.CART: "Chariot",
          Strings.NOTIFICATION: "Notification",
          Strings.STORES: "Magasins",
          Strings.ABOUT: "À propos",
          Strings.CONTACT: "Contact",
          Strings.SHIPPING: "Expédition",
          Strings.TECHNICIAN: "Technicien",
          Strings.TECHNICIANS: "Techniciens",
          Strings.MOYENXPRESS_SHIPPING: "Moyenxpress Expédition",
          Strings.REGIONS_SELLERS: "Régions Vendeurs",
          Strings.AUCTIONS: "Produits aux enchères",
          Strings.MY_ORDERS: "Mes commandes",
          Strings.SHIP_WITH_MOYEN: "Expédier avec Moyen",
          Strings.SERVICE_WITH_MOYEN: "Service Avec Moyen",
          Strings.CONTINUE: "Continuer",
          Strings.DELIVERY_ADDRESS: "Adresse de livraison",

          //Home
          Strings.SPORTS_OUTDOOR: "Sports et plein air",
          Strings.SEE_ALL: "Tout afficher",
          Strings.ALL_PRODUCTS: "Tous les produits",
          Strings.FEATURES_PRODUCT: "Caractéristiques Produits",
          Strings.SOMETHING_WENT_WRONG: "Quelque chose s'est mal passé",
          Strings.CONTENT_NOT_FOUND: "Contenu introuvable !!",
          Strings.NO_ITEMS_FOUND: "Aucun élément trouvé",
          Strings.DAILY_DEALS: "Offres quotidiennes",
          Strings.NEW_ARRIVALS: "Nouveautés",
          Strings.FREE_SHIPPING: "LIVRAISON GRATUITE",
          Strings.DESC: "Pour toutes les commandes supérieures à 9\$",
          Strings.PROMOTIONS: "Promotions",
          Strings.TOP_SELLERS: "Meilleures ventes",
          Strings.TOP_BRANDS: "Top des marques",
          Strings.VIEW_SHOP: "Voir la boutique",
          Strings.VIEW: "Voir",
          Strings.FLASH_DEALS: "Offres Flash",
          Strings.UP_TO: "Jusqu'à",
          Strings.OFF: "Désactivé",
          Strings.SHIPCARD_HEAD1: "Expédier avec Moyen Xpress",
          Strings.SHIPCARD_DESC1:
              "Utilisez Moyen Xpress comme cible d'expédition et bénéficiez de réductions exclusives.",
          Strings.SHIPCARD_HEAD2: "Envoyez n'importe quoi, n'importe où",
          Strings.SHIPCARD_DESC2:
              "Utilisez l'expédition Moyen Xpress et envoyez n'importe quoi, partout dans le monde.",
          Strings.MX_SHIPPING: "Une demande, plusieurs devis",
          Strings.MX_SHIPPING_DISC:
              "Décrivez votre besoin, envoyez un devis et obtenez plusieurs réponses de la part d'un large éventail de fournisseurs.",
          Strings.ALL_SERVICES: "Tous les Services",

          // Product Details
          Strings.PRODUCT_DETAILS: "détails du produit",
          Strings.PRODUCTS: "Des produits",
          Strings.PRODUCT: "Produit",
          Strings.CHILD_CATEGORIES: "Catégories enfants",
          Strings.TECH_PRODUCT_DETAILS: "Détails du technicien",
          Strings.DAYS: "Jours",
          Strings.REVIEWS: "Commentaires",
          Strings.CHAT_WITH_SELLER: "Discutez avec le vendeur",
          Strings.DESCRIPTION: "Description (Facultatif)",
          Strings.REVIEWS_RATING: "Commentaires et évaluations",
          Strings.CUSTOMER_Q_A: "Questions et réponses des clients",
          Strings.READ_MORE: "En savoir plus",
          Strings.READ_LESS: "Lire moins",
          Strings.DISCOUNT_PRICE: "Prix bas:",
          Strings.PIECES: "Pièces",
          Strings.BUY_NOW: "Acheter maintenant",
          Strings.Item_Added_To_Your_Cart: "Article ajouté à votre panier!",
          Strings.GO_TO_CART : "Aller au panier",
          Strings.BACK_TO_SHOPPING: "Retour aux achats",
          Strings.MY_CART: "Mon panier",
          Strings.PIECE: "Morceau",
          Strings.QUOTE: "Citation",
          Strings.CAN_NOT_ORDER: "Vous ne pouvez pas commander ce produit",
          Strings.ORDER_CONFIRMATION: "Confirmation de commande",
          Strings.UNIT_PRICE: "Prix ​​unitaire:",
          Strings.REFUNDABLE: "Remboursable:",
          Strings.AVAILABLE: "Disponible",
          Strings.NOT_AVAILABLE: "Pas disponible",

          // Locations
          Strings.MY_ADDRESS: "Mon adresse",
          Strings.MY_LOCATIONS: "Mes emplacements",
          Strings.ADDRESS: "Adresse",
          Strings.COMPLETE_ADDRESS: "Adresse complète",
          Strings.POSTAL_CODE: "Code Postal",
          Strings.CITY: "Ville",
          Strings.STATE: "État",
          Strings.PHONE: "Téléphone",
          Strings.ADD_NEW_ADDRESS: "Ajouter une nouvelle adresse",
          Strings.EDIT_ADDRESS: "Modifier l'adresse",
          Strings.CHANGE_ADDRESS: "Changement d'adresse",
          Strings.CITY_IS_REQUIRED: "La ville est obligatoire",
          Strings.SELECT_CITY: "Sélectionnez une ville",
          Strings.COUNTRY_IS_REQUIRED: "Le pays est requis",
          Strings.COUNTRY: "Pays",
          Strings.SELECT_COUNTRY: "Choisissez le pays",
          Strings.STATE_IS_REQUIRED: "L'état est requis",
          Strings.SELECT_STATE: "Sélectionnez l'état",
          Strings.FILL_BELOW_FIELDS:
              "Remplissez tous les champs ci-dessous pour ajouter une nouvelle adresse",
          Strings.FILL_BELOW_FIELDS_EDIT:
              "Remplissez tous les champs ci-dessous pour modifier l'adresse",
          Strings.SAVE: "Sauvegarder",

          // Notifications
          Strings.NOTIFICATIONS: "Notifications",
          Strings.PURCHASE_NOW: "Achetez maintenant",

          // Otp
          Strings.ENTER_OTP: "Entrez OTP",
          Strings.VERIFY: "Vérifier",
          Strings.VERIFY_EMAIL: "Vérifier l'e-mail",

          // Payment Method
          Strings.PAYMENT_METHOD: "Mode de paiement",
          Strings.PLACE_ORDER: "Passer la commande",
          Strings.ORDER_OVERVIEW: "Aperçu de la commande",
          Strings.SEND: "Envoyer",
          Strings.THANK_YOU: "Nous vous remercions de votre commande!",
          Strings.THE_ORDER: "La confirmation de commande a été"
              "Envoyé à votre adresse e-mail.",
          Strings.TOTAL_AMOUNT: "Montant total",
          Strings.ITEMS_ORDER: "Commande d'articles",
          Strings.EST_DELIVERY: "HNE. Livraison",
          Strings.CONTINUE_SHOPPING: "Continuer vos achats",

          // Auction
          Strings.NOTE: "Note",
          Strings.PRODUCT_INFO: "Information sur le produit",
          Strings.AUCTION_PRODUCT_DETAILS: "Détails du produit aux enchères",
          Strings.AUCTION_WILL_END: "L'enchère prendra fin",
          Strings.AUTO_BID: "Enchère automatique",
          Strings.START_BIDING: "Commencer à enchérir",
          Strings.BID_FOR_PRODUCT: "Enchère pour le produit",
          Strings.MIN_BID_AMOUNT: "Montant minimum de l'enchère",
          Strings.BID_AMOUNT: "Montant de l'offre",
          Strings.SUBMIT: "Soumettre",
          Strings.START_BID_AMOUNT: "Montant de l'enchère de départ",
          Strings.INCREMENT_PER_BID: "Incrément par offre",
          Strings.MAXIMUM_BID_AMOUNT: "Montant maximum de l'enchère",

          //Technician
          Strings.SELECT_AREA: "Sélectionnez votre région",

          //my_orders
          Strings.SHIPPING_ORDER: "Commandes d'expédition",
          Strings.QUOTES_ORDER: "commandes de devis",
          Strings.SHIPPING_QUOTES: "Devis d'expédition",

          //Shipping Orders
          Strings.RE_ORDER: "Réorganiser",

          //Quote Orders
          Strings.SHIPMENT_DETAILS: "Détails de l'envoi",
          Strings.PKG_DESCRIPTION: "Description du paquet",
          Strings.SHIP_COST_DETAIL: "Détails des frais d'expédition",

          //contact
          Strings.ASK_ANYTHING: "Demandez n'importe quoi",
          Strings.PHONE_NUMBER: "Numéro de téléphone",
          Strings.MESSAGE: "Message",

          //about
          Strings.HEAD1_ABOUT:
              "Achetez n'importe quoi et simplifiez-vous la vie.",
          Strings.DESC_ABOUT:
              "Moyen Xpress vous facilite la vie, d'une simple pression sur un bouton, vous pouvez acheter n'importe quoi de n'importe où, grâce à Moyen Xpress et obtenir une qualité de produit de premier ordre. Nous proposons également une grande variété de services répertoriés pour l’accessibilité et la facilité des clients.",
          Strings.DESC1_ABOUT:
              "Moyen Xpress est sur le point de devenir le plus grand magasin de commerce électronique au monde et veillera à ce que ses membres soient satisfaits et leur facilitent la vie.",
          Strings.HEAD2_ABOUT: "Comment nous devenons une grande famille.",
          Strings.DESC2_ABOUT:
              "De n'importe où, jetez Moyen Xpress et obtenez une qualité de produit de premier ordre. Nous proposons également une grande variété de services répertoriés pour l’accessibilité et la facilité des clients.",
          // ignore: equal_keys_in_map
          Strings.DESC3_ABOUT:
              "Moyen Xpress est sur le point de devenir le plus grand magasin de commerce électronique au monde et veillera à ce que ses membres soient satisfaits et leur facilitent la vie.Moyen Xpress est sur le point de devenir le plus grand magasin de commerce électronique au monde et veillera à ce que ses membres soient satisfaits et leur facilitent la vie.",

          //store
          Strings.STORE_HOME: "Accueil du magasin",
          Strings.STORE: "Magasin",
          Strings.ADDRESS_STORE:
              "1565 Woodington Circle, Lawrenceville, Géorgie, États-Unis",
          Strings.TOP_SELLING: "Meilleures ventes",
          // //Get_A_Quote
          Strings.GET_A_QUOTE: "Obtenez un devis",
          Strings.SHIPMENT_FORM: "Formulaire d'expédition",
          Strings.NEW_MEMBER: "Nouveau client",
          Strings.MOYEN_XPRESS_MEMBER: "Membre Moyen Xpress",
          Strings.DOCUMENTS: "Documents",
          Strings.PARCELS: "Colis",
          Strings.DOMESTIC: "Domestique",
          Strings.INTERNATIONAL: "International",
          Strings.AIR_FREIGHT: "Fret aérien",
          Strings.OCEAN_FREIGHT: "Fret maritime",
          Strings.BY_ROAD: "Par la route",
          Strings.FULL_NAME: "Nom et prénom",
          Strings.FROM: "Depuis:",
          Strings.To: "À:",
          Strings.CSC: "Pays, État, Ville",
          Strings.BUSINESS_EMAIL: "E-mail professionnel (facultatif)",
          Strings.BUSINESS_EMAIL_DESC: "Entrez votre email professionnel",
          Strings.BUSINESS_PHONE_NO:
              "Numéro de téléphone professionnel (facultatif)",
          Strings.BUSINESS_PHONE_NO_DESC:
              "Entrez votre numéro de téléphone professionnel",
          Strings.ADDRESS1: "Address 1",
          Strings.ADDRESS2: "Adresse 2 (facultatif)",
          Strings.SHIPMENT_DESCRIPTION: "Description de l'envoi:",
          Strings.SHIPPING_PRODUCTS: "Produits d'expédition:",
          Strings.PRODUCT_NAME: "Nom du produit",
          Strings.WEIGHT: "poids (kg)",
          Strings.LENGTH: "longueur (CM)",
          Strings.WIDTH: "Largeur (CM)",
          Strings.HEIGHT: "Hauteur (cm)",
          Strings.QUANTITY: "Quantité",
          Strings.WHAT_IN_THE_BOX: "Décrire! qu'y a-t-il dans la boîte ?",
          Strings.VALUE_OF_PARCEL: "Valeur du colis (CFA)",
          Strings.SET_PICKUP_DATE: "Définir la date de ramassage",

          //Purchase History
          Strings.PURCHASE_HISTORY: "Historique d'achat",
          Strings.REFUND: "Remboursement",
          Strings.REFUND_DESC: "Disponibilité de remboursement 3 jours ",

          //Refund Request
          Strings.REFUND_REQUEST: "Demande de remboursement",
          Strings.ORDER_CODE: "Code de commande",
          Strings.QUANTITY_TYPE: "Type de quantité",
          Strings.REFUND_TYPE: "Type de remboursement",
          Strings.RETURN_TYPE: "Type de retour",
          Strings.REFUND_REASON: "Raison du remboursement",
          Strings.DROP_OFF_ADDRESS: "Adresse de l'entrepôt de dépôt",
          Strings.DROP_OFF_STATUS: "Statut de dépôt",
          Strings.PRODUCT_IMAGE: "Image du produit",
          Strings.RETURN_COST: "Coût total du remboursement : 10,00 ",
          Strings.UPLOAD: "Télécharger",
          Strings.NOTE_REFUND:
              "Il y aura des frais de réapprovisionnement de 10 % sur tous les remboursements de produits",

          //WishList
          Strings.WISHLIST: "Liste de souhaits",

          //Profile
          Strings.PROFILE: "Profil",
          Strings.SIGN_OUT: "Se déconnecter",
          Strings.OLD_PASSWORD: "ancien mot de passe",
          Strings.NEW_PASSWORD: "nouveau mot de passe",
          Strings.CHANGE_YOUR_EMAIL: "Changez votre e-mail",
          Strings.UPDATE_PROFILE: "Mettre à jour le profil",

          //Search
          Strings.SEARCH_PRODUCT: "Rechercher un produit",
          Strings.SEARCH: "Rechercher",

          //CheckOut
          Strings.CHECK_OUT: "Vérifier",
          Strings.DELIVERY_INFO: "Continuer vers les informations de livraison",

          //Payment Method
          Strings.ESCROW: "Entiercement",
          Strings.ESCROW_DESCRIPTION:
              "Si vous cochez la case Escrow. Le vendeur recevra le paiement après votre livraison.",
          Strings.ADDITIONAL_INFO: "Des informations supplémentaires ??",
          Strings.SEND_QUOTE: "Envoyer un devis",

          //payment Method
          Strings.CARD_PAYMENT: "Paiement par carte",
          Strings.CARD_HOLDER_NAME: "Nom du titulaire",
          Strings.CARD_NUMBER: "Numéro de carte",
          Strings.EXP_MONTH: "Mois d'expiration",
          Strings.EXP_YEAR: "Année d'expiration",
          Strings.CARD_CVC: "Cvc de carte",
          Strings.COMPLETED_ORDER: "Complétez la commande",
          Strings.SELECT_PAYMENT_TYPE: "Sélectionnez le type de paiement :",
          Strings.SUMMARY: "Résumé:",
          Strings.TOTAL: "Totale",
          Strings.SUB_TOTAL: "Sous-total",
          Strings.SERVICE_NAME: "Nom du service",
          Strings.TAX: "Impôt",
          Strings.TOTAL_SHIPPING: "Expédition totale",

          Strings.SELLER: "Vendeur",
          Strings.PAYMENT_STATUS: "Statut de paiement",
          Strings.DELIVERY_STATUS: "Statut de livraison",
          Strings.SHIPPING_ADDRESS: "adresse de livraison",
          Strings.EMAIL_ADDRESS: "Adresse e-mail",
          Strings.PURCHASE_DATE: "date d'achat",
          Strings.PURCHASE_ID: "Identifiant d'achat",

          Strings.QUOTE_DETAIL: "Détails du devis: ",
          Strings.QUOTE_SUMMARY: "Résumé du devis: ",
          Strings.CUSTOMER_NAME: "Nom du client: ",
          Strings.SELLER_NAME: "Nom du Vendeur: ",
          Strings.CUSTOMER_EMAIL: "Email client: ",
          Strings.ORDER_ID: "Numéro de commande: ",
          Strings.ORDER_DATE: "Date de commande: ",
          Strings.ORDER_STATUS: "Statut de la commande: ",
          Strings.QUOTE_AMOUNT: "Montant du devis: ",
          Strings.QUOTE_ID: "Identifiant du devis: ",
          Strings.SHIPMENT_DATE: "Date d'expédition: ",
          Strings.SHIPMENT_FROM: "Expédition à partir de: ",
          Strings.SHIPMENT_TO: "Envoi à: ",
          Strings.SHIPMENT_VIA: "Expédition via: ",
          Strings.ADMIN_APPROVAL: "Approbation de l'administrateur: ",
          Strings.QUOTE_ORDER_DETAIL: "Détail de la commande de devis",
          Strings.ADDRESS_2: "Adresse 2",
          Strings.PACKAGE_DESCRIPTION: "Description du paquet:",
          Strings.BOX_SIZE: "Taille de boîte",
          Strings.PICKUP_DATE: "Date de ramassage",
          Strings.SHIPPING_fROM: "Expédition à partir de: ",
          Strings.SHIPPING_TO: "Expédition à: ",
          Strings.SHIPPING_DATE: "Date d'expédition: ",
          Strings.DOWNLOAD_INVOICE: "Télécharger la facture",
          Strings.SHOP: "boutique",

          Strings.PLACE_: "Pièce/Pièces",
          Strings.BAGS: "Sac/Sacs",
          Strings.DOZEN: "Douzaine/Dizaines",
          Strings.GALLON: "Gallons/Gallons",
          Strings.GRAM: "Gramme/Grammes",
          Strings.KILO: "Kilogramme/kilogrammes",
          Strings.METER: "Meter/Meters ",
          Strings.OUT_OF_STOCK: "En rupture de stock",
          Strings.SIZE: "Taille",
          Strings.PLACE_BID: "Placer une offre",
          Strings.STOCK: "Action:",
          Strings.LATEST: "Dernière",
          Strings.ANNOUNCEMENT: "Annonce",




          Strings.STARTING_BIDING: "Enchère de départ:",
          Strings.MY_BIDDING_AMOUNT: "Mon montant enchéri:",
          Strings.PRODUCT_CONDITION: "État du produit:",
          Strings.VEHICLE_CONDITION: "État du véhicule:",
          Strings.HIGHEST_BID: "Offre la plus élevée:",
          Strings.ORDER_CONFIRMED: "Votre commande est confirmée",
          Strings.ORDER_SUMMARY:
              "Une copie du récapitulatif de votre commande a été envoyée à",
          Strings.SUMMARY_ORDER: "Récapitulatif de la commande",
          Strings.PICKUP_ADDRESS: "Adresse de prise en charge",
          Strings.ORDER_DETAIL: "Détails de la commande",
          Strings.VARIATION: "Variation",
          Strings.DELIVERY_TYPE: "type de livraison",
          Strings.SEARCH_NOW: "Rechercher maintenant",
          Strings.I_AM_SHOPPING_FOR: "Je fais des achats pour...",
          Strings.SETTING: "Paramètre",
        },
      };
}

//eng
//french
