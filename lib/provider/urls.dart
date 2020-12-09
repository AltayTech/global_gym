class Urls {
  static const rootUrl = 'http://tgymservice.behcar.com';

//  static const placesEndPoint = '/api/places';
  static const usersEndPoint = '/api/users';
  static const confirmationCodesEndPoint = '/v1/Identities/ConfirmationCodes/Confirm';
  static const addForRegisterEndPoint = '/v1/Identities/ConfirmationCodes/AddForRegister';
  static const addUserEndPoint = '/v1/Identities/ConfirmationCodes/AddUser';
  static const signUpEndPoint = '/v1/Identities/ConfirmationCodes/Confirm';
  static const addPlanEndPoint = '/v1/Orders/UserPlans/Add';
  static const readPlansEndPoint = '/v1/BasicDefinitions/Plans/Read';
  static const loginEndPoint = '/v1/Identities/Accounts/Login';
  static const addForForgetPasswordEndPoint = '/v1/Identities/ConfirmationCodes/AddForForgetPassword';
  static const changePasswordEndPoint = '/v1/Identities/ConfirmationCodes/ChangePassword';
  static const getDietEndPoint = '/v1/Programs/UserDiets/Read';
  static const getExerciseEndPoint = '/v1/Programs/UserTraningPrograms/Read';

  // return food group list endPoint
  static const getFoodGroupListEndPoint = '/v1/FoodProducts/MenuGroups/Read';

  //add food to cart
  static const addFoodToCartEndPoint = '/v1/Orders/FoodOrders/IncreaseCartItem/';

  //decrease food from cart
  static const decreaseFoodToCartEndPoint = '/v1/Orders/FoodOrders/DecreaseCartItem/';

  //remove food from cart
  static const removeFoodFromCartEndPoint = '/v1/Orders/FoodOrders/RemoveCartItem/';

  //finalize food cart
  static const finalizeFoodToCartEndPoint = '/v1/Orders/FoodOrders/Finalize/';

  //get food cart
  static const getFoodToCartEndPoint = '/v1/Orders/FoodOrders/Read/';

  //get measurement
  static const getMeasurementEndPoint = '/v1/Programs/Measurments/Read/';

  //get measurement
  static const getMeasurementDetailEndPoint = '/v1/Programs/Measurments/Find';

  //get reserves
  static const getReserveListEndPoint = '/v1/Programs/UserReserves/Read';

  //get order history
  static const getFoodOrderHistoryEndPoint = '/v1/Orders/FinalizedFoodOrders/Read';

  //get bills
  static const getFPaymentsEndPoint = '/v1/Financials/Payments/Read';

  //get QRCode
  static const getQRCodeEndPoint = '/v1/Identities/Accounts/GenerateQR';

  //get Dashboard info
  static const getDashboardInfoEndPoint = '/v1/Identities/UserDashboard/Read';
  //get User info
  static const getProfileEndPoint = '/v1/Identities/CustomerUsers/FindProfile';

  static const userEndPoint = '/api/user';
  static const versionCode = '4';
  static const requestHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'version': versionCode
  };
}
