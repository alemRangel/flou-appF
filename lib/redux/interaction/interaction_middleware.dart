import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/interaction/interaction_actions.dart';
import 'package:redux/redux.dart';

class InteractionMiddleware extends MiddlewareClass<AppState> {
  final InteractionEndpoint interactionEndpoint;
  final EnrollmentEndpoint enrollmentEndpoint;

  InteractionMiddleware(this.interactionEndpoint, this.enrollmentEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is CreateInteractionAction) {
   //   _createInteraction(interactionEndpoint, enrollmentEndpoint, action.interaction);
      _createInteraction(interactionEndpoint, enrollmentEndpoint, action.interaction);
    } else if (action is FetchInteractionsAction) {
      //interactionEndpoint.listTest().then((List<Interaction> interactions) {
        interactionEndpoint.listTest().then((List<Interaction> interactions) {
        store.dispatch(FetchInteractionsSucceededAction(interactions));
      }).catchError((error) {
        store.dispatch(FetchInteractionsFailedAction(error));
      });
    }
    next(action);
  }
}

void _createInteraction(
  InteractionEndpoint interactionEndpoint,
  EnrollmentEndpoint enrollmentEndpoint,
  Map<String, dynamic> data,
) async {
  await interactionEndpoint.create(data);
 // await interactionEndpoint.createTest(data);
  Enrollment enrollment = await enrollmentEndpoint.getByResource(data['userId'], data['resourceId']);
  //await enrollmentEndpoint.addCompletedChapter("Enrollment1", data['chapterId']);
  await enrollmentEndpoint.addCompletedChapter(enrollment.id, data['chapterId']);
  enrollment = await enrollmentEndpoint.getByResource(data['userId'], data['resourceId']);
  num progress = enrollment.completedChapters.length / enrollment.resource.chaptersCount;

 // await enrollmentEndpoint.updateProgress("Enrollment1", progress);
  await enrollmentEndpoint.updateProgress(enrollment.id, progress);
}
