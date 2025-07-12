#!/usr/bin/env bash

# ✅ .env 파일을 환경 변수로 로딩 (파일이 존재할 경우에만)
set -a
[ -f "/home/ubuntu/app/.env" ] && source /home/ubuntu/app/.env
set +a

# ✅ JAR 경로 설정
PROJECT_ROOT="/home/ubuntu/app"
JAR_FILE="$PROJECT_ROOT/tree-0.0.1-SNAPSHOT.jar"

# ✅ 로그 경로 설정
APP_LOG="$PROJECT_ROOT/application.log"
ERROR_LOG="$PROJECT_ROOT/error.log"
DEPLOY_LOG="$PROJECT_ROOT/deploy.log"

# ✅ 현재 시간 기록
TIME_NOW=$(date +%c)

echo "$TIME_NOW > $JAR_FILE 파일 실행" >> $DEPLOY_LOG
nohup java -jar $JAR_FILE --spring.profiles.active=dev > $APP_LOG 2> $ERROR_LOG &

# ✅ 실행된 프로세스 PID 확인 및 기록
CURRENT_PID=$(pgrep -f $JAR_FILE)
echo "$TIME_NOW > 실행된 프로세스 아이디 $CURRENT_PID 입니다." >> $DEPLOY_LOG
