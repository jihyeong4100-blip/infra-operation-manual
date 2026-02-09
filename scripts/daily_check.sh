#!/bin/bash

# --- Configuration for notifications ---
# Replace with actual admin email if using email notifications.
ADMIN_EMAIL="your_email@example.com"

# Replace with your Slack Webhook URL if using Slack notifications.
# You can generate one at https://api.slack.com/apps/new
SLACK_WEBHOOK_URL=""

# Number of failed login attempts within the current log analysis to trigger an alert.
FAILED_LOGIN_THRESHOLD=3

echo "=== [$(date)] 시스템 일일 점검 시작 ==="

# 1. 디스크 사용량 확인
echo "[1] 디스크 용량 상태:"
df -h | grep '^/dev/'

# 2. 주요 서비스 상태 확인 (DNS, Web, MySQL)
services=("bind9" "apache2" "mysql")
for svc in "${services[@]}"; do
    if systemctl is-active --quiet $svc; then
        echo " - $svc: 정상 작동 중"
    else
        echo " - $svc: ⚠️ 점검 필요"
    fi
done

# 3. 보안 로그 요약 (실패한 접속 시도)
echo "[3] 최근 보안 위협 로그 (Auth Failure):"
# Get the last 20 failed logs for context. Adjust 'tail -n 20' as needed.
FAILED_LOGS=$(grep "Failed password" /var/log/auth.log | tail -n 20)
FAILED_COUNT=$(echo "$FAILED_LOGS" | wc -l)

if [ "$FAILED_COUNT" -gt "$FAILED_LOGIN_THRESHOLD" ]; then
    ALERT_SUBJECT="[ALERT] High number of failed login attempts on $(hostname)"
    ALERT_MESSAGE="⚠️ [ALERT] High number of failed login attempts detected on $(hostname)!
Threshold: $FAILED_LOGIN_THRESHOLD
Detected: $FAILED_COUNT

Recent failed attempts:
$FAILED_LOGS"

    echo "$ALERT_MESSAGE"
    
    # --- Notification Logic ---
    # Send Slack Notification (uncomment and configure SLACK_WEBHOOK_URL to use)
    if [ -n "$SLACK_WEBHOOK_URL" ]; then
        # Check if curl is available
        if command -v curl &> /dev/null; then
            curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$(echo "$ALERT_MESSAGE" | sed 's/"/\\"/g')\"}" "$SLACK_WEBHOOK_URL" &>/dev/null
            echo "  - Slack notification sent."
        else
            echo "  - Warning: 'curl' command not found. Cannot send Slack notification."
        fi
    fi

    # Send Email Notification (uncomment and configure ADMIN_EMAIL to use)
    # This requires 'mailutils' or 'bsd-mailx' to be installed (e.g., sudo apt-get install mailutils)
    # if [ -n "$ADMIN_EMAIL" ]; then
    #     # Check if mail command is available
    #     if command -v mail &> /dev/null; then
    #         echo "$ALERT_MESSAGE" | mail -s "$ALERT_SUBJECT" "$ADMIN_EMAIL"
    #         echo "  - Email notification sent to $ADMIN_EMAIL."
    #     else
    #         echo "  - Warning: 'mail' command not found. Cannot send email notification."
    #     fi
    # fi

else
    echo "  - Failed login attempts within threshold ($FAILED_COUNT/$FAILED_LOGIN_THRESHOLD)."
    # Still show the logs even if not alerting, but only the most recent ones.
    if [ -n "$FAILED_LOGS" ]; then
        echo "$FAILED_LOGS"
    else
        echo "  - No failed login attempts found."
    fi
fi

echo "=== 점검 완료 ==="
