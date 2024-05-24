class EmailConfirmationState {
  String? error;
  bool isLoading;
  bool isSuccess;

  EmailConfirmationState({
    this.error,
    this.isLoading = false,
    this.isSuccess = false,
  });

  EmailConfirmationState copyWith({
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return EmailConfirmationState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}