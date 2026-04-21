/// Supabase + FastAPI configuration.
/// Fill in your values here — the app will connect to your backend automatically.
/// DO NOT commit this file with real credentials if the repo is public.
class AppConfig {
  // ── Supabase ────────────────────────────────────────────────────────────────
  /// Your Supabase project URL (found in Supabase dashboard → Settings → API)
  static const supabaseUrl = 'YOUR_SUPABASE_URL_HERE';

  /// Supabase anon/public key (safe to expose in client)
  static const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY_HERE';

  // ── FastAPI backend ─────────────────────────────────────────────────────────
  /// Your FastAPI server URL (e.g. http://localhost:8000 in dev)
  static const apiBaseUrl = 'http://localhost:8000';

  // ── Feature flags ────────────────────────────────────────────────────────────
  /// Set to true once your Supabase + FastAPI backend is live
  static const useRealBackend = false;

  /// When true, uses Supabase Auth (GoTrue) instead of mock login
  static const useSupabaseAuth = false;

  /// When true, persists auth token in flutter_secure_storage
  static const useSecureStorage = true;
}
