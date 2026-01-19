#!/bin/bash

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
grep "Failed password" /var/log/auth.log | tail -n 5

echo "=== 점검 완료 ==="
