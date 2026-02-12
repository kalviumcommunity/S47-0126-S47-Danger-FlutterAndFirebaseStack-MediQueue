/// Token Generation & Queue System Documentation
/// 
/// This document explains the token generation, display, storage, and reset logic for walk-in patient queue management.
///
/// 1. TokenGenerator (token_generator.dart)
///    - Generates unique, sequential tokens per department (A, B, C, ...)
///    - Format: [LETTER]-[NUMBER] (e.g., A-001)
///    - Resets counters daily using SharedPreferences
///    - Usage:
///        String token = await TokenGenerator.generateToken(department: 'Cardiology');
///
/// 2. TokenDisplay (token_display.dart)
///    - Widget to display tokens in a large, readable format
///    - Usage:
///        TokenDisplay(token: token, isLarge: true)
///
/// 3. saveToken (save_token.dart)
///    - Persists token and patient info to the database (e.g., sqflite)
///    - Usage:
///        await saveToken(database, token, patientId);
///
/// 4. checkAndResetTokens (token_reset_util.dart)
///    - Checks if the date has changed and resets token counters if needed
///    - Usage:
///        await checkAndResetTokens();
///
/// Integration Example:
///   await checkAndResetTokens();
///   String token = await TokenGenerator.generateToken(department: 'ENT');
///   await saveToken(database, token, patientId);
///   // Display token using TokenDisplay
///
/// Acceptance Criteria:
///   - Tokens are unique, sequential, and reset daily
///   - Multiple departments supported
///   - Tokens are saved and displayed clearly
