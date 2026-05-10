import 'package:tourguide_app/features/agreements/model/agreement_model.dart';

abstract class IAgreementsRepository {
  Future<List<AgreementModel>> getPendingAgreements();

  Future<void> acceptAgreement(int agreementId);
}
