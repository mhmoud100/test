import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/componets/nav_bar/nav_bar/nav_bar_widget.dart';
import '/pages/componets/notification/notification/notification_widget.dart';
import '/pages/componets/notification/unread_notification/unread_notification_widget.dart';
import '/pages/componets/response_messages/successful_message/successful_message_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget>
    with TickerProviderStateMixin {
  late NotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.checkinternetConnection(
        context,
      );
    });

    animationsMap.addAll({
      'unreadNotificationOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).info,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: const Color(0xFF002855),
            automaticallyImplyLeading: false,
            title: Text(
              FFLocalizations.of(context).getText(
                'ryczqjnk' /* Notifications */,
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineMediumFamily,
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).headlineMediumFamily),
                  ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) => FutureBuilder<ApiCallResponse>(
              future: GetAllNotificationsCall.call(
                apiSecret: currentUserData?.apiSecret,
                apiKey: currentUserData?.apiKey,
                baseUrl: FFAppState().baseURL,
                mobileApp: 'Talentio',
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      width: 85.0,
                      height: 85.0,
                      child: SpinKitRipple(
                        color: Color(0xFF002855),
                        size: 85.0,
                      ),
                    ),
                  );
                }
                final stackGetAllNotificationsResponse = snapshot.data!;

                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().errors = functions.jsonToErrors(
                        stackGetAllNotificationsResponse.jsonBody,
                        stackGetAllNotificationsResponse.statusCode.toString());
                    safeSetState(() {});
                    if (currentUserData?.debugMode == 1) {
                      context.pushNamed(
                        'debug',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: const AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(dialogContext).unfocus();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: SizedBox(
                                height: 175.0,
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                child: SuccessfulMessageWidget(
                                  apiMessege: FFAppState().errors.error,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        RefreshIndicator(
                          backgroundColor: FlutterFlowTheme.of(context).info,
                          onRefresh: () async {
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              'NotificationPage',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 12.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.show = 'All';
                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'v5uosemw' /* All    */,
                                          ),
                                          icon: Icon(
                                            Icons.done_all,
                                            color: valueOrDefault<Color>(
                                              _model.show == 'All'
                                                  ? FlutterFlowTheme.of(context)
                                                      .alternate
                                                  : const Color(0xFF002855),
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                            ),
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.038,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            iconAlignment: IconAlignment.start,
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 2.0, 0.0),
                                            color: _model.show == 'All'
                                                ? const Color(0xFF2F598B)
                                                : FlutterFlowTheme.of(context)
                                                    .alternate,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily,
                                                  color: valueOrDefault<Color>(
                                                    _model.show == 'All'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .info
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                  ),
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily),
                                                ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Color(0x27000000),
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _model.show = 'Unread';
                                          safeSetState(() {});
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'i0k3791e' /* Unread */,
                                        ),
                                        icon: Icon(
                                          Icons.mark_email_unread_sharp,
                                          color: valueOrDefault<Color>(
                                            _model.show == 'Unread'
                                                ? FlutterFlowTheme.of(context)
                                                    .alternate
                                                : const Color(0xFF002855),
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.038,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 2.0, 0.0),
                                          color: _model.show == 'Unread'
                                              ? const Color(0xFF2F598B)
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color: valueOrDefault<Color>(
                                                  _model.show == 'Unread'
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .info
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                                ),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily),
                                              ),
                                          elevation: 0.0,
                                          borderSide: const BorderSide(
                                            color: Color(0x27000000),
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.5,
                                  indent: 5.0,
                                  endIndent: 5.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                if (_model.show == 'Unread')
                                  Builder(
                                    builder: (context) => Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 50.0),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: UnreadNotificationsCall.call(
                                          apiKey: currentUserData?.apiKey,
                                          apiSecret: currentUserData?.apiSecret,
                                          baseUrl: FFAppState().baseURL,
                                          mobileApp: 'Talentio',
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: SizedBox(
                                                width: 85.0,
                                                height: 85.0,
                                                child: SpinKitRipple(
                                                  color: Color(0xFF002855),
                                                  size: 85.0,
                                                ),
                                              ),
                                            );
                                          }
                                          final unreadUnreadNotificationsResponse =
                                              snapshot.data!;

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              FFAppState().errors =
                                                  functions.jsonToErrors(
                                                      unreadUnreadNotificationsResponse
                                                          .jsonBody,
                                                      unreadUnreadNotificationsResponse
                                                          .statusCode
                                                          .toString());
                                              safeSetState(() {});
                                              if (currentUserData?.debugMode ==
                                                  1) {
                                                context.pushNamed(
                                                  'debug',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          const AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: SizedBox(
                                                          height: 175.0,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.85,
                                                          child:
                                                              SuccessfulMessageWidget(
                                                            apiMessege:
                                                                FFAppState()
                                                                    .errors
                                                                    .error,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 8.0, 0.0, 8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      if (getJsonField(
                                                            unreadUnreadNotificationsResponse
                                                                .jsonBody,
                                                            r'''$.message[:].message''',
                                                          ) !=
                                                          null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.apiResultoe1 =
                                                                  await MarkNotificationsAsReadCall
                                                                      .call(
                                                                apiKey:
                                                                    currentUserData
                                                                        ?.apiKey,
                                                                apiSecret:
                                                                    currentUserData
                                                                        ?.apiSecret,
                                                                baseUrl:
                                                                    FFAppState()
                                                                        .baseURL,
                                                                mobileApp:
                                                                    'Talentio ',
                                                              );

                                                              if ((_model
                                                                      .apiResultoe1
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                _model.readAll =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                                if (animationsMap[
                                                                        'unreadNotificationOnActionTriggerAnimation'] !=
                                                                    null) {
                                                                  await animationsMap[
                                                                          'unreadNotificationOnActionTriggerAnimation']!
                                                                      .controller
                                                                      .forward(
                                                                          from:
                                                                              0.0);
                                                                }
                                                                FFAppState()
                                                                    .numNotifications = 0;
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                _model.readAll =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'mar4zfiy' /* All Read */,
                                                            ),
                                                            icon: const Icon(
                                                              Icons
                                                                  .checklist_rtl,
                                                              color: Color(
                                                                  0xFF061926),
                                                              size: 15.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.045,
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          4.0,
                                                                          16.0,
                                                                          4.0),
                                                              iconPadding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: const Color(
                                                                  0xE5FFFFFF),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0x27000000),
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                if (getJsonField(
                                                      unreadUnreadNotificationsResponse
                                                          .jsonBody,
                                                      r'''$.message[:].message''',
                                                    ) !=
                                                    null)
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  10.0,
                                                                  5.0,
                                                                  25.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final unRead =
                                                              getJsonField(
                                                            unreadUnreadNotificationsResponse
                                                                .jsonBody,
                                                            r'''$.message''',
                                                          ).toList();

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children:
                                                                List.generate(
                                                                    unRead
                                                                        .length,
                                                                    (unReadIndex) {
                                                              final unReadItem =
                                                                  unRead[
                                                                      unReadIndex];
                                                              return Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        3.0,
                                                                        10.0,
                                                                        3.0,
                                                                        10.0),
                                                                child:
                                                                    UnreadNotificationWidget(
                                                                  key: Key(
                                                                      'Keyctt_${unReadIndex}_of_${unRead.length}'),
                                                                  message:
                                                                      getJsonField(
                                                                    unReadItem,
                                                                    r'''$.message''',
                                                                  ),
                                                                  subject:
                                                                      getJsonField(
                                                                    unReadItem,
                                                                    r'''$.subject''',
                                                                  ),
                                                                  date:
                                                                      getJsonField(
                                                                    unReadItem,
                                                                    r'''$.creation''',
                                                                  ),
                                                                  docType:
                                                                      getJsonField(
                                                                    unReadItem,
                                                                    r'''$.document_type''',
                                                                  ),
                                                                ).animateOnActionTrigger(
                                                                  animationsMap[
                                                                      'unreadNotificationOnActionTriggerAnimation']!,
                                                                  effects: [
                                                                    MoveEffect(
                                                                      curve: Curves
                                                                          .easeInOut,
                                                                      delay: (unReadIndex *
                                                                              100)
                                                                          .ms,
                                                                      duration:
                                                                          1000.0
                                                                              .ms,
                                                                      begin: const Offset(
                                                                          0.0,
                                                                          0.0),
                                                                      end: Offset(
                                                                          FFLocalizations.of(context).languageCode == 'en'
                                                                              ? -200.0
                                                                              : 200.0,
                                                                          0.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                if (getJsonField(
                                                      unreadUnreadNotificationsResponse
                                                          .jsonBody,
                                                      r'''$.message[:].message''',
                                                    ) ==
                                                    null)
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  30.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                        ),
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      20.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Lottie.asset(
                                                                'assets/jsons/login.json',
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.3,
                                                                fit: BoxFit
                                                                    .contain,
                                                                animate: true,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'lrd8xbvq' /* No notifications  */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (_model.show == 'All')
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (_model.show == 'All')
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 10.0, 5.0, 55.0),
                                          child: Builder(
                                            builder: (context) {
                                              final notification = getJsonField(
                                                stackGetAllNotificationsResponse
                                                    .jsonBody,
                                                r'''$.message''',
                                              ).toList();

                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    notification.length,
                                                    (notificationIndex) {
                                                  final notificationItem =
                                                      notification[
                                                          notificationIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(3.0, 7.0,
                                                                3.0, 7.0),
                                                    child: NotificationWidget(
                                                      key: Key(
                                                          'Keyjqm_${notificationIndex}_of_${notification.length}'),
                                                      subject: getJsonField(
                                                        notificationItem,
                                                        r'''$.subject''',
                                                      ),
                                                      date: getJsonField(
                                                        notificationItem,
                                                        r'''$.creation''',
                                                      ),
                                                      docType: getJsonField(
                                                        notificationItem,
                                                        r'''$.document_type''',
                                                      ),
                                                      message: getJsonField(
                                                        notificationItem,
                                                        r'''$.message''',
                                                      ),
                                                      isViewed: getJsonField(
                                                        notificationItem,
                                                        r'''$.is_viewed''',
                                                      ),
                                                      name: getJsonField(
                                                        notificationItem,
                                                        r'''$.name''',
                                                      ).toString(),
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                        ),
                                      if (getJsonField(
                                            stackGetAllNotificationsResponse
                                                .jsonBody,
                                            r'''$.message[:].message''',
                                          ) ==
                                          null)
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 30.0, 5.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                              ),
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 20.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Lottie.asset(
                                                      'assets/jsons/login.json',
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.8,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.3,
                                                      fit: BoxFit.contain,
                                                      animate: true,
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        's5i7vnbt' /* No notifications  */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                fontSize: 17.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ].addToEnd(const SizedBox(height: 25.0)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 1.0),
                          child: wrapWithModel(
                            model: _model.navBarModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const NavBarWidget(
                              pageName: 'NotificationPage',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
