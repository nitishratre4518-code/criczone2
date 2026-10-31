export async function onRequest({ request, env }) {
  return new Response(JSON.stringify({
    ok: true,
    service: "criczone-pages-functions",
    path: new URL(request.url).pathname,
    method: request.method,
    bot_token_configured: Boolean(env.BOT_TOKEN),
    telegram_db_configured: Boolean(env.TELEGRAM_DB),
    admin_dashboard_key_configured: Boolean(env.ADMIN_DASHBOARD_KEY || env.TELEGRAM_ADMIN_KEY),
    timestamp: new Date().toISOString()
  }), {
    status: 200,
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Cache-Control": "no-store"
    }
  });
}
