#!/bin/bash

# 启动模拟器（如果尚未启动）
if flutter devices | grep -q "emulator-"; then
  echo "✅ 模拟器已运行"
else
  echo "🚀 启动模拟器中..."
  nohup flutter emulators --launch Medium_Phone_API_36.0 > /dev/null 2>&1 & disown
fi

