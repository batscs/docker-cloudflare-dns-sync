echo "" > /app/.env
echo "cloudflare_email=$cloudflare_email" >> /app/.env
echo "cloudflare_auth_key=$cloudflare_auth_key" >> /app/.env
echo "cloudflare_zoneid=$cloudflare_zoneid" >> /app/.env

crontab /app/data/app.cron
cron -f
