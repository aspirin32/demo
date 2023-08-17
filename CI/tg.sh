#!/bin/bash

# bot token
TOKEN=6035895695:AAHNidSIJbar5jPHotYELA2xnmpuWlMulU0
CHAT_ID=-1001863047576
curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="message" "https://api.telegram.org/bot$TOKEN/sendMessage"