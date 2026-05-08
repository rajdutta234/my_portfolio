import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_services/contact_services.dart';
import '../models/contact_model.dart';

// State model for contact submission
class ContactState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  ContactState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ContactState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ContactNotifier extends Notifier<ContactState> {
  @override
  ContactState build() {
    return ContactState();
  }

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final contact = ContactModel(
        name: name,
        email: email,
        message: message,
      );

      final service = ref.read(contactServiceProvider);
      await service.sendContactMessage(contact);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void resetStatus() {
    state = ContactState();
  }
}

// Providers
final contactServiceProvider = Provider((ref) => ContactServices());

final contactNotifierProvider = NotifierProvider<ContactNotifier, ContactState>(() {
  return ContactNotifier();
});