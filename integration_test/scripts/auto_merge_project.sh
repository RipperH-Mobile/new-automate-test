#!/bin/bash

# ==========================================
# ⚙️ CONFIGURATION
# ==========================================
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
PROJECT_PATH="$(cd "$(dirname "$0")" && pwd)"

# 3. Branch Config
SOURCE_BRANCH="origin/dev"
TARGET_BRANCH="test/automate"

# ==========================================
# 🔧 FUNCTIONS
# ==========================================

# ฟังก์ชันส่งข้อความเข้า Slack
send_slack() {
  local message="$1"
  # ส่ง curl ไปที่ Slack (แบบเงียบๆ ไม่โชว์ output รกหน้าจอ)
  curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\": \"$message\"}" \
    "$SLACK_WEBHOOK_URL" > /dev/null
}

# ==========================================
# 🚀 SCRIPT START
# ==========================================

# ย้ายเข้าโฟลเดอร์โปรเจกต์
cd "$PROJECT_PATH" || { echo "❌ Error: เข้าโฟลเดอร์ไม่ได้"; exit 1; }

echo "--- [$(date)] 📂 Working in: $PROJECT_PATH ---"
#send_slack "เริ่มรัน Script auto merge"

# 1. ดึงข้อมูลล่าสุด
git fetch --all --quiet

# 2. นับจำนวน Commit ใหม่
NEW_COMMITS=$(git rev-list --count origin/$TARGET_BRANCH..$SOURCE_BRANCH)

if [ "$NEW_COMMITS" -gt 0 ]; then
  echo "⚡️ พบ $NEW_COMMITS รายการใหม่! กำลัง Merge..."

  # Checkout และ Pull เตรียมไว้
  git checkout $TARGET_BRANCH
  git pull origin $TARGET_BRANCH --quiet 

  # 3. เริ่ม Merge
  if git merge $SOURCE_BRANCH --no-edit; then
    
    # ✅ กรณีสำเร็จ (SUCCESS)
    echo "✅ Merge ลงเครื่องเรียบร้อย!"
    echo "👉 รอให้คุณสั่ง Push ด้วยตัวเอง"
    
    # แจ้งเตือนเข้า Slack (#test-modern)
    MSG="*✅ Auto Sync สำเร็จ!* (Branch: \`$TARGET_BRANCH\`)\nรับโค้ดใหม่จาก Dev มาแล้ว $NEW_COMMITS commits\n👉 *รอให้คุณสั่ง Push ขึ้น Server ครับ*"
    send_slack "$MSG"
    
  else
    # ❌ กรณีล้มเหลว (CONFLICT)
    echo "❌ เกิด Conflict!"
    # แจ้งเตือนเข้า Slack (#test-modern) พร้อมแท็กเรียกทุกคน (@here)
    MSG="*🚨 Auto Sync ล้มเหลว!* (Conflict)\nไม่สามารถ Merge Dev เข้ามาที่ \`$TARGET_BRANCH\` ได้\n👉 *<!here> กรุณาเข้ามาแก้ Conflict ด่วน*"
    send_slack "$MSG"
    
    exit 1
  fi

else
    echo "😴 ไม่มีอะไรเปลี่ยนแปลง"
    MSG="😴 ไม่มีอะไรเปลี่ยนแปลง"
    send_slack "$MSG"
fi

echo "--- จบการทำงาน ---"
echo ""