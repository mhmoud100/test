import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'pie_chart_for_home_page_model.dart';
export 'pie_chart_for_home_page_model.dart';

class PieChartForHomePageWidget extends StatefulWidget {
  const PieChartForHomePageWidget({super.key});

  @override
  State<PieChartForHomePageWidget> createState() =>
      _PieChartForHomePageWidgetState();
}

class _PieChartForHomePageWidgetState extends State<PieChartForHomePageWidget> {
  late PieChartForHomePageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PieChartForHomePageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: LeaveTypesPercentageForPieChartCall.call(
        apiKey: currentUserData?.apiKey,
        apiSecret: currentUserData?.apiSecret,
        baseUrl: FFAppState().baseURL,
        userId: currentUserData?.id,
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
        final columnLeaveTypesPercentageForPieChartResponse = snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (functions.checkApiResponse(
                    columnLeaveTypesPercentageForPieChartResponse.jsonBody)
                ? (LeaveTypesPercentageForPieChartCall.message(
                      columnLeaveTypesPercentageForPieChartResponse.jsonBody,
                    )!
                        .length >
                    1)
                : false)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(3.0, 5.0, 3.0, 5.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'dashboard',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    3.0, 0.0, 3.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '1lr90kh3' /* More */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF46718B),
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final leavesState = functions
                                .filterZeroPercentageFromMessage(getJsonField(
                                  columnLeaveTypesPercentageForPieChartResponse
                                      .jsonBody,
                                  r'''$.message''',
                                  true,
                                )!)
                                .toList();

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(leavesState.length,
                                        (leavesStateIndex) {
                                  final leavesStateItem =
                                      leavesState[leavesStateIndex];
                                  return Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.38,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.23,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).info,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                          child: CircularPercentIndicator(
                                            percent: valueOrDefault<double>(
                                              functions
                                                  .getDynamicEquationResult(
                                                      functions
                                                          .convertDoubleToInt(
                                                              getJsonField(
                                                            leavesStateItem,
                                                            r'''$.percentage''',
                                                          ))
                                                          .toDouble()),
                                              0.0,
                                            ),
                                            radius: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.105,
                                            lineWidth: 8.0,
                                            animation: true,
                                            animateFromLastPercent: true,
                                            progressColor: () {
                                              if (functions.convertDoubleToInt(
                                                      getJsonField(
                                                    leavesStateItem,
                                                    r'''$.percentage''',
                                                  )) >=
                                                  75) {
                                                return const Color(0xE7C31B1B);
                                              } else if (functions
                                                      .convertDoubleToInt(
                                                          getJsonField(
                                                    leavesStateItem,
                                                    r'''$.percentage''',
                                                  )) <
                                                  75) {
                                                return const Color(0xFF38B000);
                                              } else if (functions
                                                      .convertDoubleToInt(
                                                          getJsonField(
                                                    leavesStateItem,
                                                    r'''$.percentage''',
                                                  )) <=
                                                  50) {
                                                return const Color(0xFF5B7F95);
                                              } else {
                                                return const Color(0xE7C31B1B);
                                              }
                                            }(),
                                            backgroundColor: const Color(0x6DD9E6F2),
                                            center: Text(
                                              '${functions.convertDoubleToInt(getJsonField(
                                                    leavesStateItem,
                                                    r'''$.percentage''',
                                                  )).toString()}%',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 4.0, 0.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    leavesStateItem,
                                                    r'''$.leave_type''',
                                                  )?.toString(),
                                                  'Leaves',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                                    .divide(const SizedBox(width: 8.0))
                                    .addToStart(const SizedBox(width: 3.0))
                                    .addToEnd(const SizedBox(width: 3.0)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
