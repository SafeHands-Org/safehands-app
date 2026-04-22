sealed class AppException implements Exception {
  String get header;
  String get content;
}

class SessionException extends AppException {
  @override
  final String header = "Session Time Out", content;

  SessionException([this.content = "Log in to continue using the app."]);
}

class ServerException extends AppException {
  @override
  final String header = "Server Error", content;

  ServerException([this.content = "Something went wrong on our end. Please try again later."]);
}

class ServerRequestException extends AppException {
  @override
  final String header = "Bad Request", content;

  ServerRequestException([this.content = "We couldn't process your request. Please try again"]);
}

class ServerTimeoutException extends AppException {
  @override
  final String header = 'Request Timed Out', content;

  ServerTimeoutException([this.content = 'The server took too long to respond. Please try again.']);
}

class NoConnectionException extends AppException {
  @override
  final String header = "No Connection", content;

  NoConnectionException([this.content = "We couldn't load your information. Check your connection and try again."]);
}

class UnexpectedErrorException extends AppException {
  @override
  final String header = "Unexpected Error", content;

  UnexpectedErrorException([this.content = "Something went wrong. Please try again."]);
}

class ForbiddenException extends AppException {
  @override
  final String header = 'Access Denied', content;

  ForbiddenException([this.content = "You don't have permission to perform this action."]);
}

class AccessDeniedException extends AppException {
  @override
  final String header = "Access Denied", content;

  AccessDeniedException([this.content = "You don't have permission to view this."]);
}

class CredentialException extends AppException {
  @override
  final String header = 'Login Failed', content;

  CredentialException([this.content = 'Email or password is incorrect']);
}

class SyncFailedException extends AppException {
  @override
  final String header = "Information Outdated", content;

  SyncFailedException([this.content = "Your information isn't up to date. Pull to refresh or try again."]);
}

class NotFoundException extends AppException {
  @override
  final String header = "No Results Found", content;

  NotFoundException([this.content = "We couldn't find this request. Check the name or try again."]);
}

class DuplicateException extends AppException {
  @override
  final String header = "Already Exists", content;

  DuplicateException([this.content = "A resource with this information already exists."]);
}

class NotificationsDisabledException extends AppException {
  @override
  final String header = "Reminders Off", content;

  NotificationsDisabledException([this.content = "Enable notifications to receive medication reminders."]);
}

class TooManyRequestsException extends AppException {
  @override
  final String header = "Too Many Requests", content;

  TooManyRequestsException([this.content = "Please wait a moment and try again."]);
}

