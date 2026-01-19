# 🛡️ Linux Network Security & Service Ops

네트워크 보안 강화 및 핵심 서버 서비스(DNS, Mail, Web, File Sharing) 운영 프로젝트입니다. 실무 환경에서의 보안 위협을 방어하고 운영 효율성을 극대화하는 것에 초점을 맞췄습니다.

## 🚀 프로젝트 성과
- **보안성 강화**: 불필요한 포트 및 외부 트래픽 **95% 차단** (ufw/iptables 활용)
- **운영 효율화**: Shell Script 자동화로 일일 점검 시간 **80% 단축** (30분 → 5분)
- **기술 표준화**: 비전문가를 위한 트러블슈팅 매뉴얼 제작 및 배포

## 🛠️ 주요 기술 스택
- **OS**: Ubuntu Linux
- **Services**: BIND9 (DNS), Postfix/Dovecot (Mail), Apache/PHP/MySQL (APM), Samba (File Sharing)
- **Security**: UFW, iptables, Wireshark (Packet Analysis)
- **Automation**: Bash Shell Script

## 🔍 핵심 구현 내용
1. **서버 구축 및 요새화**: 서비스별 최소 권한 원칙에 따른 보안 설정
2. **네트워크 분석**: Wireshark를 이용한 패킷 분석으로 병목 현상 및 지연 원인 해결
3. **접근 제어**: 미인가 IP 및 포트에 대한 엄격한 차단 정책 적용

## 📂 파일 구조
- `/scripts`: 자동화 및 보안 설정 스크립트
- `/docs`: 비전문가용 서비스 운영 및 트러블슈팅 매뉴얼
- `/config`: 주요 서비스 설정 파일 샘플
