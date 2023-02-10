enum UIState {
  init,
  loading,
  loaded,
  success,
  error,
  end;
}

class CollaboratorState {
  static const String stateNull = "null";
  static const String stateNew = "new";
  static const String stateMemberApproved = "member_approved";
  static const String stateMemberRejected = "member_rejected";
  static const String stateApproved = "approved"; //stt admin vừa mới chấp nhận
  static const String stateRejected = "rejected"; //stt admin vừa mới từ chối
}

class SharedPreferenceKey {
  static const String xLicenseKey = "xLicenseKey";
  static const String idToken = "idToken";
  static const String username = "username";
}
