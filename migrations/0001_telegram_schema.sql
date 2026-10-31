-- CRICZONE Telegram Admin + membership schema. Safe to apply repeatedly.
CREATE TABLE IF NOT EXISTS telegram_login_requests (
 nonce TEXT PRIMARY KEY, status TEXT NOT NULL DEFAULT 'pending',
 return_url TEXT NOT NULL, created_at INTEGER NOT NULL, expires_at INTEGER NOT NULL,
 telegram_user_id TEXT, verified_at INTEGER, telegram_username TEXT,
 telegram_first_name TEXT, telegram_last_name TEXT
);
CREATE INDEX IF NOT EXISTS idx_tg_login_user_status ON telegram_login_requests(telegram_user_id,status);
CREATE INDEX IF NOT EXISTS idx_tg_login_expiry ON telegram_login_requests(expires_at);
CREATE TABLE IF NOT EXISTS telegram_login_rate_limits (
 ip_hash TEXT PRIMARY KEY, window_start INTEGER NOT NULL, request_count INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS telegram_status_checks (
 nonce TEXT PRIMARY KEY, last_checked_at INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS telegram_categories (
 id TEXT PRIMARY KEY, parent_id TEXT, name TEXT NOT NULL,
 emoji TEXT NOT NULL DEFAULT '📺', url TEXT NOT NULL,
 enabled INTEGER NOT NULL DEFAULT 1, sort_order INTEGER NOT NULL DEFAULT 0,
 updated_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_tg_categories_parent_order ON telegram_categories(parent_id,enabled,sort_order);
CREATE TABLE IF NOT EXISTS telegram_settings (
 key TEXT PRIMARY KEY, value TEXT NOT NULL, updated_at INTEGER NOT NULL
);
INSERT OR IGNORE INTO telegram_settings(key,value,updated_at) VALUES('popup_enabled','1',unixepoch());
CREATE TABLE IF NOT EXISTS telegram_category_access (
 token TEXT PRIMARY KEY, telegram_user_id TEXT NOT NULL, target_url TEXT NOT NULL,
 expires_at INTEGER NOT NULL, used INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_tg_category_access_expiry ON telegram_category_access(expires_at);
CREATE TABLE IF NOT EXISTS telegram_join_invites (
 invite_link TEXT PRIMARY KEY, nonce TEXT NOT NULL, expires_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_tg_join_invites_nonce ON telegram_join_invites(nonce);
