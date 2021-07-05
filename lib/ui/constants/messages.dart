const String kBaseUrl =
    'https://www.mydealtrackerweb.staging.cloudware.ng/ussd/q8uc_mobile/wpapi/v1';

const String SERVER_DOWN = 'No internet connection!';
const String PARSING_ERROR =
    'Server is currently under maintenance, Try again later';
const String DEVELOPER_ERROR = 'Developer Error';
const String NO_SERIAL = 'Serial number not available for this product';
const String SUCCESSFUL = 'Operation Successful';
const String UNKNOWN_USER =
    'This user does not exist or incorrect password and username';
const String LOGGED_OUT_USER = 'Logged out';
const String LOGGED_IN_USER = 'Logged in';
const String EMPTY_FIELD = 'No serial number for the product';
const String INCOMPLETE_PASSWORD = 'Password must be more than 8 characters';
const String PASSWORD_CRITERIA_FAILED = 'Password needs to have a number';
const String PASSWORD_DOES_NOT_MATCH = 'Passwords do not match';
const String NEEDS_PASSWORD_CHANGE = 'needs_pwd_change';
const String CREDENTIALS_ARE_WRONG =
    'These credentials are wrong \nCheck and try again';
const int SERVER_OKAY = 200;
const int WRONG_SERVER = 101;
const int SERVER_ERROR = 103;
const int CREATED = 201;
const int SERVER_MAINTENANCE = 500;
const int POORLY_FORMATTED_REQUEST = 400;
const int WRONG_CREDENTIALS = 401;
const int RESOURCE_NOT_FOUND = 404;
const int REQUEST_CANNOT_BE_PROCESSED = 422;
const int ACCOUNT_ALREADY_EXISTS = 409;
const int REDIRECT = 307;
