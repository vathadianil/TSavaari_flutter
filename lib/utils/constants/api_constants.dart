class ApiEndPoint {
  //Splash Image
  static String splashImageUrl =
      'https://s3.ap-south-1.amazonaws.com/files.tsavaari.com/splash/splash.png';

  //Book Qr
  static String getToken = "qr/getToken";
  static String getStations = "qr/getStations";
  static String getFare = 'qr/getTicketFare';
  static String createQrPaymentOrder = 'cfpg/cashfree/createOrder';
  static String verifyPayment = 'cfpg/cashfree/getOrder';
  static String generateTicket = 'qr/generateTicket';
  static String verifyGenerateTicket = 'qr/getOrderStatusByMerchantOrderId';
  static String refundPaymentIntimation = 'qr/RefundInitiatedByMerchant';
  static String getFareCalculation = 'db/fare_calculator?fromStation=';
  static String getActiveTickets = 'qr/getActiveTickets';
  static String getPastTickets = 'qr/getExpiredTickets';
  static String refundPreview = "qr/refunPreview";
  static String createRefundOrder = "cfpg/cashfree/refundOrder";
  static String refundOrderStatus = "cfpg/cashfree/getRefund";
  static String refundConfirm = "qr/refunConfirmed";
  static String changeDestinationPreview = "qr/changeDestinationPreview";
  static String changeDestinationConfirm = "qr/changeDestination";

  //Card Rechage
  static String getCardDetailsByUser = 'db/get_card_details?userID=';
  static String getLastRechargeStatus =
      'HydRechargeApi/api/NEBULACARD_TSA_TXN_STATUS';
  static String getSqsDetailsUrl =
      "files.tsavaari.com/jsondata/GetSqsDetails.json";
  static String validateNebulaCardUrl = 'HydAppAPI/api/VALIDATE_NEBULACARD';
  static String getCardTrxDetails = 'HydRechargeApi/api/NEBULACARD_TXN_DETAILS';
  static String addOrUpdateCardDetails = 'db/add_update_card';
  static String deleteCard = 'db/delete_card?ID=';

  //Hyd Metro Website Url
  static String hydMetroWebsiteUrl = 'https://www.ltmetro.com/penalty-charter/';
}
