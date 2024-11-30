class ApiEndPoint {
  static String splashImageUrl =
      'https://s3.ap-south-1.amazonaws.com/files.tsavaari.com/splash/splash.png';
  static String getToken = "qr/getToken";
  static String getStations = "qr/getStations";
  static String getFare = 'qr/getTicketFare';
  static String createQrPaymentOrder = 'cfpg/cashfree/createOrder';
  static String verifyPayment = 'cfpg/cashfree/getOrder';
  static String generateTicket = 'qr/generateTicket';
  static String getFareCalculation =
      'getActiveMetroStationsFareandDistanceList/services.do?fromStation=';
  static String getActiveTickets =
      'getactiveticketdetailsbytsavaari/services.do';
  static String getPastTickets =
      'getexpiredticketdetailsbytsavaari/services.do';
}