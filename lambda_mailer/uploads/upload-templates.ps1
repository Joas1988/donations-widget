# Upload Email Templates to S3
$BUCKET = "ent-happy-hearts"
$REGION = "eu-central-1"

Write-Host "📧 Uploading email templates to S3..." -ForegroundColor Cyan

$templates = @(
    "donation_confirmation_en.html",
    "donation_confirmation_cs.html",
    "donation_confirmation_sk.html",
    "donation_confirmation_de.html"
)

foreach ($template in $templates) {
    $file = "../templates/$template"
    $key = "email_templates/$template"
    
    if (Test-Path $file) {
        Write-Host "📤 Uploading $template..." -ForegroundColor Yellow
        aws s3 cp $file "s3://$BUCKET/$key" `
            --content-type "text/html; charset=utf-8" `
            --region $REGION
        Write-Host "   ✅ Done" -ForegroundColor Green
    } else {
        Write-Host "   ❌ File not found: $file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🎉 Upload complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Verify:" -ForegroundColor Cyan
Write-Host "   aws s3 ls s3://$BUCKET/email_templates/ --region $REGION"
