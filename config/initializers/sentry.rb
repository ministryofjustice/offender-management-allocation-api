sentry_dsn = Rails.configuration.sentry_dsn

if sentry_dsn
  Raven.configure do |config|
    config.dsn = CGI.escape(sentry_dsn.strip)
  end
else
  STDOUT.puts '[WARN] Sentry is not configured (SENTRY_DSN)'
end
