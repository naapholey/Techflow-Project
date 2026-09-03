#!/bin/bash
echo "============================================"
echo "Verifying the health of the application"
echo "============================================"

sleep 5 #allow some time for the application to start before checking health

for i in {1..5}; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://3.89.31.80:5000")
    if [ "$STATUS" -eq 200 ]; then
        echo "✅ Deployment successful! Service is responsive at http://3.89.31.80:5000"
        exit 0
    else
        echo "⚠️ Health check attempt #$i failed. Retrying in 5 seconds..."
        sleep 5
    fi
done

echo "❌ Error: Application failed health check validation after 5 attempts."
exit 1