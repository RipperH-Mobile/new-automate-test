#!/bin/bash

# กำหนดโฟลเดอร์ที่เก็บผลลัพธ์ (อ้างอิงจาก run_test_batch.sh ของคุณ)
RESULT_DIR="integration_test/test_results"

echo "📊 Analyzing test results in $RESULT_DIR..."

# เช็คว่ามีโฟลเดอร์และไฟล์ CSV หรือไม่ (ป้องกันกรณีรันเทสพังตั้งแต่ต้นจนไม่มีไฟล์)
if [ ! -d "$RESULT_DIR" ] || [ -z "$(ls -A $RESULT_DIR/*.csv 2>/dev/null)" ]; then
  TOTAL_TESTS=0
  TOTAL_PASS=0
  TOTAL_FAIL=0
  STATUS="⚠️ **TEST EXECUTION FAILED / NO RESULTS**"
  COLOR=16711680 # สีแดง
else
  # นับจำนวนจากไฟล์ CSV (นับผลคำว่า PASSED / FAILED ตามที่ set ไว้ใน step.dart)
  TOTAL_TESTS=$(tail -q -n +2 $RESULT_DIR/*.csv | wc -l | tr -d ' ')
  TOTAL_PASS=$(grep -h "PASSED" $RESULT_DIR/*.csv | wc -l | tr -d ' ')
  TOTAL_FAIL=$(grep -h "FAILED" $RESULT_DIR/*.csv | wc -l | tr -d ' ')

  if [ "$TOTAL_FAIL" -eq 0 ] && [ "$TOTAL_TESTS" -gt 0 ]; then
    STATUS="✅ **ALL TESTS PASSED**"
    COLOR=3066993 # สีเขียว
  else
    STATUS="❌ **SOME TESTS FAILED**"
    COLOR=16711680 # สีแดง
  fi
fi

# จัดรูปแบบข้อความส่งเข้า Discord
DESCRIPTION="$STATUS\n• Total Tests: $TOTAL_TESTS\n• Passed: $TOTAL_PASS\n• Failed: $TOTAL_FAIL\n\n**Branch:** \`$GITHUB_REF_NAME\`\n**Triggered by:** $GITHUB_ACTOR"

# ส่ง Payload ไปยัง Discord Webhook
curl -s -X POST -H 'Content-Type: application/json' \
  --data "{
    \"embeds\": [{
      \"title\": \"🤖 Patrol Automate Test Report\",
      \"description\": \"$DESCRIPTION\",
      \"color\": $COLOR
    }]
  }" \
  "$DISCORD_WEBHOOK_URL" > /dev/null

echo "✅ Sent summary to Discord!"