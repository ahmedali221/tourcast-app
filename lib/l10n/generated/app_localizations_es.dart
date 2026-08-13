// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Guía turística NileTech';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonTryAgain => 'Inténtalo de nuevo';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonSubmit => 'Enviar';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonDone => 'Hecho';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonActive => 'Activo';

  @override
  String get commonCopied => '¡Copiado!';

  @override
  String get commonContactSupport => 'Contactar con soporte';

  @override
  String get commonPayoutsUnavailable =>
      'Los pagos están disponibles una vez que se verifica su cuenta.';

  @override
  String get commonPleaseContactSupport => 'Por favor contacte al soporte.';

  @override
  String get commonLogout => 'Cerrar sesión';

  @override
  String get commonLogoutConfirm => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get commonSomethingWentWrong => 'Algo salió mal';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSubtitle => 'Elige tu idioma preferido';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageArabic => 'Árabe';

  @override
  String get languageChinese => 'Chino';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageJapanese => 'Japonés';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get navHome => 'Inicio';

  @override
  String get navMarketplace => 'Mercado';

  @override
  String get navWallet => 'Cartera';

  @override
  String get navSupport => 'Soporte';

  @override
  String get navProfile => 'Perfil';

  @override
  String get validatorEmailRequired => 'Se requiere correo electrónico';

  @override
  String get validatorEmailInvalid =>
      'Introduzca una dirección de correo electrónico válida';

  @override
  String get validatorPasswordRequired => 'Se requiere contraseña';

  @override
  String get validatorPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get validatorConfirmPasswordRequired =>
      'Por favor confirma tu contraseña';

  @override
  String get validatorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String validatorFieldRequired(String field) {
    return '$field es obligatorio';
  }

  @override
  String get validatorDefaultFieldName => 'este campo';

  @override
  String get validatorAmountRequired => 'Se requiere cantidad';

  @override
  String get validatorAmountInvalid => 'Introduce un importe válido';

  @override
  String validatorMinimumAmount(String min) {
    return 'El monto mínimo es \$$min';
  }

  @override
  String get authTagline => 'Tu guía. Tu negocio.';

  @override
  String get loginWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get loginSubtitle => 'Inicie sesión en su cuenta de guía';

  @override
  String get loginEmailLabel => 'Dirección de correo electrónico';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginNoAccount => '¿No tienes una cuenta?';

  @override
  String get loginRegisterLink => 'Registrarse';

  @override
  String get registerHeading => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Únase a NileTech como guía turístico';

  @override
  String get registerFullNameLabel => 'Nombre completo';

  @override
  String get registerEmailLabel => 'Correo electrónico';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerReferralCodeLabel => 'Código de referencia (opcional)';

  @override
  String get registerButton => 'Crear cuenta';

  @override
  String get registerAlreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get registerLoginLink => 'Iniciar sesión';

  @override
  String get forgotPasswordTitle => 'Olvidé mi contraseña';

  @override
  String get forgotPasswordHeading => 'Restablece tu contraseña';

  @override
  String get forgotPasswordSubtitle =>
      'Ingresa tu correo electrónico y te enviaremos un enlace de reinicio.';

  @override
  String get forgotPasswordEmailLabel => 'Dirección de correo electrónico';

  @override
  String get forgotPasswordSendButton => 'Enviar enlace de reinicio';

  @override
  String get forgotPasswordSuccessHeading => 'Revisa tu bandeja de entrada';

  @override
  String get forgotPasswordSuccessBody =>
      'Se ha enviado un enlace para restablecer la contraseña a su dirección de correo electrónico.';

  @override
  String get verifyEmailResentSnackbar =>
      'Correo electrónico de verificación reenviado';

  @override
  String get verifyEmailHeading => 'Verifique su correo electrónico';

  @override
  String get verifyEmailBody =>
      'Le enviamos un enlace de verificación a su correo electrónico. Por favor revise su bandeja de entrada y haga clic en el enlace para activar su cuenta.';

  @override
  String get verifyEmailContinueButton => 'He verificado, continuar';

  @override
  String get verifyEmailResendButton => 'Reenviar correo electrónico';

  @override
  String get homeVerificationRequiredTitle => 'Verificación requerida';

  @override
  String get homeAccountUnderReviewTitle => 'Cuenta en revisión';

  @override
  String get homeApplicationRejectedTitle => 'Solicitud rechazada';

  @override
  String get homeVerificationRequiredMessage =>
      'Debe enviar sus documentos de verificación antes de poder acceder a la aplicación.';

  @override
  String get homePendingReviewMessage =>
      'Nuestro equipo está revisando su solicitud de guía. Se le notificará una vez aprobado.';

  @override
  String get homeRejectedMessage =>
      'Su solicitud no fue aprobada. Revise las notas a continuación y comuníquese con el soporte.';

  @override
  String get homeSubmitVerificationCta => 'Enviar verificación';

  @override
  String get homeReviewNotesLabel => 'Notas de revisión';

  @override
  String get greetingMorning => 'Buenos dias';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Tu saldo';

  @override
  String get homeRequestPayout => 'Solicitar pago';

  @override
  String get homeCommissions => 'Comisiones';

  @override
  String get homeReferrals => 'Referencias';

  @override
  String get homeAnnouncements => 'Anuncios';

  @override
  String get homeMyPromoCodes => 'Mis códigos promocionales';

  @override
  String get homeNoPromoCodes => 'Aún no hay códigos promocionales';

  @override
  String get homePendingBannerMessage =>
      'Su verificación está siendo revisada. Puede navegar por la aplicación, pero no puede crear códigos promocionales, referencias ni solicitar pagos hasta que se apruebe.';

  @override
  String get notificationsTrayTitle => 'Notificaciones';

  @override
  String get notificationsMarkAllRead => 'Marcar todo como leído';

  @override
  String get notificationsEmptyTitle => 'Aún no hay notificaciones';

  @override
  String get notificationsEmptyMessage => '¡Estáis todos atrapados!';

  @override
  String get notificationsNewSection => 'Nuevo';

  @override
  String get notificationsEarlierSection => 'Antes';

  @override
  String get profileTitle => 'Mi perfil';

  @override
  String get profileEditUnavailable =>
      'La edición de perfil está disponible una vez que se verifica su cuenta.';

  @override
  String get profileCompleteness => 'Completitud del perfil';

  @override
  String get profileCountry => 'País';

  @override
  String get profileCity => 'ciudad';

  @override
  String get profileYearsExperienceLabel => 'Años de experiencia';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count años',
      one: '$count año',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Idiomas';

  @override
  String get profileSpecializations => 'Especializaciones';

  @override
  String get profileBio => 'Biografía';

  @override
  String get profileNoBio => 'Aún no se ha agregado ninguna biografía.';

  @override
  String get profileDeleteAccount => 'Eliminar cuenta';

  @override
  String get profileDeleteConfirm =>
      'Esta acción es permanente y no se puede deshacer. ¿Está seguro?';

  @override
  String get profileWallet => 'Cartera';

  @override
  String get profileViewAll => 'Ver todo →';

  @override
  String get profileAvailableBalance => 'Saldo disponible';

  @override
  String get profilePayoutAccount => 'Cuenta de pago';

  @override
  String get profileManage => 'Administrar →';

  @override
  String get profileSetupPayoutAccount => 'Configurar cuenta de pago';

  @override
  String get profileUpdatedSuccess => '¡Perfil actualizado exitosamente!';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editProfileChangePhoto => 'Cambiar foto';

  @override
  String get editProfileSelectCountry => 'Seleccionar país';

  @override
  String get editProfileSaveChanges => 'Guardar cambios';

  @override
  String get editProfileSelectCountryTitle => 'Seleccionar país';

  @override
  String get editProfileSearchCountryHint => 'Buscar país...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'Seleccione $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Hecho ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Buscar...';

  @override
  String editProfileApplyCount(int count) {
    return 'Aplicar ($count seleccionado)';
  }

  @override
  String get editProfileAddChip => '+ Agregar';

  @override
  String get verificationTitle => 'Verificación de identidad';

  @override
  String get verificationDocumentDetails => 'Detalles del documento';

  @override
  String get verificationNationalIdLabel => 'Número de DNI';

  @override
  String get verificationLicenseLabel => 'Número de licencia de guía';

  @override
  String get verificationUploadDocuments => 'Cargar documentos';

  @override
  String get verificationUploadCaption =>
      'Cargue copias claras y legibles de sus documentos.';

  @override
  String get verificationIdFrontTitle => 'DNI — Frente';

  @override
  String get verificationIdFrontSubtitle =>
      'Anverso de su documento nacional de identidad';

  @override
  String get verificationFormatMax2mb => 'JPEG o PNG • Máximo 2 MB';

  @override
  String get verificationIdBackTitle => 'DNI — Volver';

  @override
  String get verificationIdBackSubtitle =>
      'Reverso de su documento nacional de identidad';

  @override
  String get verificationLicenseTitle => 'Licencia de guía';

  @override
  String get verificationLicenseSubtitle =>
      'Documento de licencia oficial de guía turístico.';

  @override
  String get verificationFormatMax5mb => 'JPEG o PNG • Máximo 5 MB';

  @override
  String get verificationSubmitButton => 'Enviar para verificación';

  @override
  String get verificationUploaded => 'subido';

  @override
  String get verificationTapToUpload => 'Toca para subir';

  @override
  String get verificationRejectedBanner =>
      'Sus documentos fueron rechazados. Por favor vuelva a enviar.';

  @override
  String get verificationPendingBanner =>
      'Sus documentos están bajo revisión. Te avisaremos.';

  @override
  String get verificationSubmittedDocuments => 'Documentos enviados';

  @override
  String get verificationVerifiedTitle => 'Identidad verificada';

  @override
  String get verificationVerifiedSubtitle =>
      'Su identidad ha sido verificada exitosamente.';

  @override
  String get verificationSuccessHeading => 'Documentos enviados';

  @override
  String get verificationSuccessBody =>
      'Sus documentos de verificación se han enviado correctamente. Nuestro equipo los revisará y le notificará el resultado.';

  @override
  String get verificationSuccessInfoBanner =>
      'La revisión suele tardar entre 1 y 3 días hábiles.';

  @override
  String get verificationGoHome => 'Ir a casa';

  @override
  String get marketplaceTitle => 'Mercado';

  @override
  String get marketplaceSearchHint => 'Buscar aplicaciones...';

  @override
  String get marketplaceEmptyTitle => 'No hay aplicaciones disponibles';

  @override
  String get marketplaceEmptyMessage =>
      'Vuelve más tarde para ver nuevas aplicaciones.';

  @override
  String get marketplaceViewDetails => 'Ver detalles →';

  @override
  String get appDetailsCouldNotOpenStore =>
      'No se pudo abrir el enlace de la tienda';

  @override
  String get appDetailsGooglePlay => 'GooglePlay';

  @override
  String get appDetailsAppStore => 'Tienda de aplicaciones';

  @override
  String get appDetailsAbout => 'Acerca de';

  @override
  String get appDetailsAvailablePlans => 'Planes disponibles';

  @override
  String get appDetailsPromoUnavailable =>
      'Los códigos promocionales están disponibles una vez que se verifica su cuenta.';

  @override
  String get appDetailsGenerateButton => '+ Generar';

  @override
  String get appDetailsFailedLoadPromoCodes =>
      'No se pudieron cargar los códigos promocionales.';

  @override
  String get appDetailsGenerateHint =>
      'Toca \"+ Generar\" para crear tu primer código.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'No se pudo generar el código de promoción. Por favor inténtalo de nuevo.';

  @override
  String get appDetailsCopyTooltip => 'Copiar';

  @override
  String get appDetailsFailedLoadUsage => 'No se pudo cargar el uso.';

  @override
  String get appDetailsNoUsage => 'Aún no se usa';

  @override
  String get appDetailsCreatePromoTitle => 'Crear código promocional';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Ingrese un nombre personalizado para su código de promoción o déjelo vacío para generar uno automáticamente.';

  @override
  String get appDetailsPromoNameLabel =>
      'Nombre del código promocional (opcional)';

  @override
  String get appDetailsPromoNameHint =>
      'por ej. AHMED20 — dejar vacío para generar automáticamente';

  @override
  String get appDetailsGenerate => 'generar';

  @override
  String get appDetailsPreview => 'Vista previa';

  @override
  String get appDetailsFree => 'Gratis';

  @override
  String get walletTitle => 'Cartera';

  @override
  String get walletTransactionHistory => 'Historial de transacciones';

  @override
  String get walletNoTransactions => 'Aún no hay transacciones';

  @override
  String get walletNoTransactionsMessage =>
      'Su historial de transacciones aparecerá aquí.';

  @override
  String get walletPayoutRequestsTitle => 'Solicitudes de pago';

  @override
  String get walletPayoutRequestsSubtitle => 'Ver y administrar sus pagos';

  @override
  String get payoutProfileSaved => '¡Perfil de pagos guardado!';

  @override
  String get payoutRequestSubmitted => 'Solicitud de pago enviada';

  @override
  String get payoutMethodTitle => 'Método de pago';

  @override
  String get payoutPaymentDetailsTitle => 'Detalles de pago';

  @override
  String get payoutManageAccount => 'Administrar cuenta de pago';

  @override
  String get payoutHistorySection => 'Historia';

  @override
  String get payoutNoRequests => 'Aún no hay solicitudes de pago';

  @override
  String get payoutNoRequestsMessage =>
      'Tus solicitudes de pago aparecerán aquí.';

  @override
  String get payoutChooseMethod => 'Elige cómo quieres recibir tu dinero.';

  @override
  String get payoutNoMethodsAvailable => 'No hay métodos de pago disponibles';

  @override
  String get payoutInfoBanner =>
      'Esta información se guarda en su perfil de pago y se utiliza para todos los retiros futuros.';

  @override
  String get payoutSaveContinue => 'Guardar y continuar';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Disponible: $amount';
  }

  @override
  String get payoutChange => 'Cambiar';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'El monto mínimo de pago es \$10';

  @override
  String get payoutSubmitRequest => 'Enviar solicitud';

  @override
  String get payoutAmountLabel => 'Monto (USD)';

  @override
  String get paymentMethodsSaved => '¡Cuenta de pago guardada!';

  @override
  String get paymentMethodsTitle => 'Métodos de pago';

  @override
  String get paymentMethodsNoneAvailable =>
      'No hay métodos de pago disponibles';

  @override
  String get paymentMethodsChoose => 'Elige un método de pago';

  @override
  String get paymentMethodsAll => 'Todos los métodos';

  @override
  String get paymentMethodsActiveBadge => 'ACTIVO';

  @override
  String get paymentMethodsSetUp => 'configurar';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Actualice sus detalles de pago guardados para $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Esta se convertirá en su cuenta de pago activa.';

  @override
  String get paymentMethodsSetActiveButton => 'Establecer como cuenta activa';

  @override
  String get commissionsTitle => 'Comisiones';

  @override
  String get commissionsTotalEarned => 'Comisiones totales ganadas';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transacciones',
      one: '$count transacción',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'Historia de la comisión';

  @override
  String get commissionsEmptyTitle => 'Aún no hay comisiones';

  @override
  String get commissionsEmptyMessage =>
      'Tus comisiones ganadas aparecerán aquí.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Código de promoción: $code';
  }

  @override
  String get commissionsDirectSale => 'Venta directa';

  @override
  String get referralsTitle => 'Referencias';

  @override
  String get referralsTotal => 'Referencias totales';

  @override
  String get referralsTotalEarned => 'Total ganado';

  @override
  String get referralsGenerateNew => 'Generar nuevo código de referencia';

  @override
  String get referralsUnavailable =>
      'Los enlaces de referencia están disponibles una vez que se verifica su cuenta.';

  @override
  String get referralsCodesSection => 'Códigos de referencia';

  @override
  String get referralsEmptyTitle => 'Aún no hay referencias';

  @override
  String get referralsEmptyMessage =>
      '¡Genera un código y compártelo para comenzar a ganar!';

  @override
  String get referralsCodeCopied => '¡Código copiado!';

  @override
  String referralsUsedBy(String user) {
    return 'Utilizado por $user';
  }

  @override
  String get referralsNotUsedYet => 'Aún no usado';

  @override
  String referralsRegisteredOn(String date) {
    return 'Registrado $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Enlace de referencia generado';

  @override
  String get referralsShareSubtitle =>
      'Comparte tu código o enlace para comenzar a ganar.';

  @override
  String get referralsCodeLabel => 'Código de referencia';

  @override
  String get referralsLinkLabel => 'Enlace de referencia';

  @override
  String get referralsLinkCopied => 'Enlace copiado!';

  @override
  String get referralsActivityTitle => 'Actividad del usuario referido';

  @override
  String get referralsNoActivityData => 'Sin datos de actividad';

  @override
  String get referralsActivityWillAppear =>
      'La actividad aparecerá una vez que el usuario esté activo.';

  @override
  String get referralsWindowSection => 'Ventana de referencia';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Suscripciones ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'Eventos de uso de aplicaciones ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Canjes de promociones ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Aún no hay actividad';

  @override
  String referralsItemFallback(int index) {
    return 'Artículo $index';
  }

  @override
  String get supportTicketsTitle => 'Boletos de soporte';

  @override
  String get supportFilterAll => 'Todos';

  @override
  String get supportFilterOpen => 'Abierto';

  @override
  String get supportFilterPending => 'Pendiente';

  @override
  String get supportFilterClosed => 'Cerrado';

  @override
  String get supportEmptyTitle => 'Aún no hay entradas';

  @override
  String get supportEmptyMessage =>
      'Toque + para abrir un nuevo ticket de soporte.';

  @override
  String get newTicketTitle => 'Nuevo billete';

  @override
  String get newTicketSubmitted => 'Boleto enviado exitosamente!';

  @override
  String get newTicketCategoryLabel => 'categoría';

  @override
  String get newTicketPriorityLabel => 'Prioridad';

  @override
  String get newTicketSubjectLabel => 'Asunto';

  @override
  String get newTicketSubjectRequired => 'Se requiere sujeto';

  @override
  String get newTicketMessageLabel => 'Mensaje';

  @override
  String get newTicketMessageRequired => 'Se requiere mensaje';

  @override
  String get newTicketSubmitButton => 'Enviar ticket';

  @override
  String get newTicketCategoryTechnical => 'Técnico';

  @override
  String get newTicketCategoryPayment => 'Pago';

  @override
  String get newTicketPriorityNormal => 'normales';

  @override
  String get newTicketPriorityHigh => 'Alto';

  @override
  String get newTicketPriorityUrgent => 'Urgente';

  @override
  String get ticketDetailRefreshTooltip => 'Actualizar';

  @override
  String get ticketDetailNoReplies => 'Aún no hay respuestas.';

  @override
  String get ticketDetailTeamWillRespond =>
      'Nuestro equipo responderá en breve.';

  @override
  String get ticketDetailReplyHint => 'Escribe una respuesta...';

  @override
  String get ticketDetailClosed => 'Este billete está cerrado.';

  @override
  String get agreementsTitle => 'Acuerdos Legales';

  @override
  String get agreementsAccepted => 'Acuerdo aceptado';

  @override
  String get agreementsAllAcceptedTitle => '¡Todos los acuerdos aceptados!';

  @override
  String get agreementsNoPending => 'No tienes acuerdos pendientes.';

  @override
  String get agreementsAcceptedStatus => 'Aceptado';

  @override
  String get agreementsPendingStatus => 'Pendiente de su aceptación';

  @override
  String get agreementsCheckboxLabel =>
      'He leído y acepto los términos anteriores.';

  @override
  String get agreementsAcceptButton => 'Aceptar Acuerdo';

  @override
  String get knowledgeCenterTitle => 'Centro de conocimiento';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Empezando';

  @override
  String get knowledgeCenterCategoryPayments => 'Pagos';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Aplicaciones y herramientas';

  @override
  String get knowledgeCenterCategoryAccount => 'cuenta';

  @override
  String get knowledgeCenterEmptyTitle => 'Aún no hay artículos';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Vuelve más tarde para ver contenido nuevo.';

  @override
  String get subscriptionPageStub => 'Página de suscripciones';
}
