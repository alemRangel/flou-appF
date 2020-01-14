import 'package:learning/data/data.dart';

class CreateInteractionAction {
  final Map<String, dynamic> interaction;

  CreateInteractionAction(this.interaction);
}

class FetchInteractionsAction {
  final String resourceId;
  final String userId;

  FetchInteractionsAction(this.userId, this.resourceId);
}

class FetchInteractionsSucceededAction {
  final List<Interaction> interactions;

  FetchInteractionsSucceededAction(this.interactions);
}

class FetchInteractionsFailedAction {
  final Exception error;

  FetchInteractionsFailedAction(this.error);
}
