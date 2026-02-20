// import 'dart:async';
// import 'dart:developer';
// import 'dart:isolate';

// /// Isolate message types for communication between main isolate and worker isolate
// class IsolateMessage {
//   IsolateMessage({
//     required this.type,
//     this.data,
//     this.sendPort,
//   });
//   final String type;
//   final dynamic data;
//   final SendPort? sendPort;
// }

// /// Response from isolate operations
// class IsolateResponse {
//   IsolateResponse({
//     required this.success,
//     this.data,
//     this.error,
//   });
//   final bool success;
//   final dynamic data;
//   final String? error;
// }

// /// Main isolate handler for player operations
// class AppIsolates {
//   static Isolate? _playerFetchIsolate;
//   static SendPort? _playerFetchSendPort;
//   static ReceivePort? _playerFetchReceivePort;
//   // static Completer<PlayerFetchResponse>? _playerFetchCompleter;

//   /// Initialize the player fetch isolate
//   static Future<void> initializePlayerFetchIsolate() async {
//     if (_playerFetchIsolate != null) {
//       log('✅ Player fetch isolate already initialized');
//       return;
//     }

//     log('🔄 Initializing player fetch isolate...');
//     _playerFetchReceivePort = ReceivePort();
//     _playerFetchIsolate = await Isolate.spawn(
//       _playerFetchIsolateEntry,
//       _playerFetchReceivePort!.sendPort,
//     );

//     _playerFetchReceivePort!.listen(_handlePlayerFetchMessage);
//     log('✅ Player fetch isolate spawned, waiting for ready signal...');
//   }

//   /// Dispose the player fetch isolate
//   static void disposePlayerFetchIsolate() {
//     _playerFetchIsolate?.kill();
//     _playerFetchIsolate = null;
//     _playerFetchSendPort = null;
//     _playerFetchReceivePort?.close();
//     _playerFetchReceivePort = null;
//   }

//   /// Fetch players in background isolate
//   static Future<PlayerFetchResponse> fetchPlayersInBackground({
//     required int gameweekNumber,
//     required String sessionId,
//     required String baseUrl,
//     String? tournamentId,
//   }) async {
//     await initializePlayerFetchIsolate();

//     // Wait for isolate to be ready (max 5 seconds)
//     var attempts = 0;
//     while (_playerFetchSendPort == null && attempts < 50) {
//       await Future<void>.delayed(const Duration(milliseconds: 100));
//       attempts++;
//       if (attempts % 10 == 0) {
//         log('⏳ Waiting for isolate to be ready... (attempt $attempts/50)');
//       }
//     }

//     if (_playerFetchSendPort == null) {
//       return PlayerFetchResponse(
//         players: [],
//         playersModel: [],
//         error: 'Isolate not initialized after timeout',
//       );
//     }

//     _playerFetchCompleter = Completer<PlayerFetchResponse>();

//     final request = PlayerFetchRequest(
//       gameweekNumber: gameweekNumber,
//       tournamentId: tournamentId,
//       isTournament: tournamentId != null,
//       sessionId: sessionId,
//       baseUrl: baseUrl,
//     );

//     _playerFetchSendPort!.send(
//       IsolateMessage(
//         type: 'FETCH_PLAYERS',
//         data: request,
//       ),
//     );

//     return _playerFetchCompleter!.future;
//   }

//   /// Process players in background isolate
//   static Future<PlayerFetchResponse> processPlayersInBackground({
//     required List<BuildSquadPlayerModel> players,
//     required int gameweekNumber,
//     String? tournamentId,
//   }) async {
//     await initializePlayerFetchIsolate();

//     // Wait for isolate to be ready (max 5 seconds)
//     var attempts = 0;
//     while (_playerFetchSendPort == null && attempts < 50) {
//       await Future<void>.delayed(const Duration(milliseconds: 100));
//       attempts++;
//       if (attempts % 10 == 0) {
//         log('⏳ Waiting for isolate to be ready... (attempt $attempts/50)');
//       }
//     }

//     if (_playerFetchSendPort == null) {
//       return PlayerFetchResponse(
//         players: [],
//         playersModel: [],
//         error: 'Isolate not initialized after timeout',
//       );
//     }

//     _playerFetchCompleter = Completer<PlayerFetchResponse>();

//     final request = PlayerFetchRequest(
//       gameweekNumber: gameweekNumber,
//       tournamentId: tournamentId,
//       isTournament: tournamentId != null,
//       players: players,
//     );

//     _playerFetchSendPort!.send(
//       IsolateMessage(
//         type: 'PROCESS_PLAYERS',
//         data: request,
//       ),
//     );

//     return _playerFetchCompleter!.future;
//   }

//   /// Handle messages from player fetch isolate
//   static void _handlePlayerFetchMessage(dynamic message) {
//     if (message is IsolateMessage) {
//       switch (message.type) {
//         case 'ISOLATE_READY':
//           _playerFetchSendPort = message.sendPort;
//           log('✅ Player fetch isolate ready - SendPort received');
//         case 'PLAYERS_FETCHED':
//           log('✅ Players fetched successfully in isolate');
//           _playerFetchCompleter?.complete(message.data as PlayerFetchResponse);
//         case 'PLAYERS_PROCESSED':
//           log('✅ Players processed successfully in isolate');
//           _playerFetchCompleter?.complete(message.data as PlayerFetchResponse);
//         case 'PLAYERS_ERROR':
//           log('❌ Error in isolate: ${message.data}');
//           _playerFetchCompleter?.complete(
//             PlayerFetchResponse(
//               players: [],
//               playersModel: [],
//               error: message.data as String?,
//             ),
//           );
//       }
//     }
//   }

//   /// Entry point for player fetch isolate
//   static void _playerFetchIsolateEntry(SendPort mainSendPort) {
//     final receivePort = ReceivePort();
//     mainSendPort.send(
//       IsolateMessage(
//         type: 'ISOLATE_READY',
//         sendPort: receivePort.sendPort,
//       ),
//     );

//     receivePort.listen((message) async {
//       if (message is IsolateMessage) {
//         try {
//           final request = message.data as PlayerFetchRequest;

//           if (message.type == 'FETCH_PLAYERS') {
//             log(
//               '🔄 Isolate: Fetching players for gameweek ${request.gameweekNumber}',
//             );

//             // TODO: Implement actual API fetching in isolate
//             // For now, return empty list as placeholder
//             final response = PlayerFetchResponse(
//               players: [],
//               playersModel: [],
//               error: 'API fetching in isolate not yet implemented',
//             );

//             mainSendPort.send(
//               IsolateMessage(
//                 type: 'PLAYERS_FETCHED',
//                 data: response,
//               ),
//             );
//           } else if (message.type == 'PROCESS_PLAYERS') {
//             log(
//               '🔄 Isolate: Processing ${request.players?.length ?? 0} players for gameweek ${request.gameweekNumber}',
//             );

//             // Process players in isolate (shuffle, filter, etc.)
//             final shuffledPlayers = List<BuildSquadPlayerModel>.from(
//               request.players ?? [],
//             )..shuffle();

//             final response = PlayerFetchResponse(
//               players: shuffledPlayers,
//               playersModel: request.players ?? [],
//             );

//             mainSendPort.send(
//               IsolateMessage(
//                 type: 'PLAYERS_PROCESSED',
//                 data: response,
//               ),
//             );
//           }
//         } catch (e, stackTrace) {
//           log('❌ Isolate error: $e', error: e, stackTrace: stackTrace);
//           mainSendPort.send(
//             IsolateMessage(
//               type: 'PLAYERS_ERROR',
//               data: 'Isolate error: $e',
//             ),
//           );
//         }
//       }
//     });
//   }
// }
