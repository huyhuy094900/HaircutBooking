# PowerShell script to update shifts in HaircutBooking database
# This script updates the shifts to the new schedule: 8-12, 12-17, 17-21

Write-Host "Updating HaircutBooking shifts..." -ForegroundColor Green

# Read the SQL file content
$sqlContent = Get-Content "reset_staff.sql" -Raw

# You can run this manually in your MySQL client or phpMyAdmin
Write-Host "SQL commands to run:" -ForegroundColor Yellow
Write-Host "====================" -ForegroundColor Yellow
Write-Host $sqlContent -ForegroundColor Cyan

Write-Host "`nPlease run the above SQL commands in your MySQL client or phpMyAdmin to update the shifts." -ForegroundColor Green
Write-Host "Or copy and paste the content of reset_staff.sql into your MySQL client." -ForegroundColor Green

Write-Host "`nNew shift schedule:" -ForegroundColor Yellow
Write-Host "- Ca sáng: 8:00 - 12:00" -ForegroundColor White
Write-Host "- Ca chiều: 12:00 - 17:00" -ForegroundColor White  
Write-Host "- Ca tối: 17:00 - 21:00" -ForegroundColor White

Write-Host "`nPress any key to continue..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 