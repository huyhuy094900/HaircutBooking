# HaircutBooking Database Setup Script
# PowerShell version

Write-Host "========================================" -ForegroundColor Green
Write-Host "    HaircutBooking Database Setup" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check if MySQL is installed
try {
    $mysqlVersion = mysql --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ MySQL found: $mysqlVersion" -ForegroundColor Green
    } else {
        throw "MySQL not found"
    }
} catch {
    Write-Host "❌ ERROR: MySQL is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install MySQL and add it to your system PATH" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Starting database setup..." -ForegroundColor Yellow

# Get MySQL credentials
$mysqlUser = Read-Host "Enter MySQL username (default: root)"
if ([string]::IsNullOrEmpty($mysqlUser)) {
    $mysqlUser = "root"
}

$mysqlPassword = Read-Host "Enter MySQL password" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($mysqlPassword)
$mysqlPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Create temporary SQL file with credentials
$tempSqlFile = "temp_setup.sql"
$sqlContent = Get-Content "CompleteDatabase.sql" -Raw

# Run MySQL command
try {
    if ([string]::IsNullOrEmpty($mysqlPassword)) {
        # No password
        $sqlContent | mysql -u $mysqlUser
    } else {
        # With password
        $sqlContent | mysql -u $mysqlUser -p$mysqlPassword
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "    DATABASE SETUP COMPLETE!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Database: HaircutBooking" -ForegroundColor Cyan
        Write-Host "Admin Account: admin@haircut.com / admin123" -ForegroundColor Cyan
        Write-Host "Test Users:" -ForegroundColor Cyan
        Write-Host "  - john@example.com / password123" -ForegroundColor Cyan
        Write-Host "  - anna@example.com / password123" -ForegroundColor Cyan
        Write-Host "  - mike@example.com / password123" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "✅ You can now run the application!" -ForegroundColor Green
        Write-Host ""
        
        # Test database connection
        Write-Host "Testing database connection..." -ForegroundColor Yellow
        $testQuery = "USE HaircutBooking; SELECT COUNT(*) as user_count FROM Users;"
        if ([string]::IsNullOrEmpty($mysqlPassword)) {
            $result = $testQuery | mysql -u $mysqlUser --silent
        } else {
            $result = $testQuery | mysql -u $mysqlUser -p$mysqlPassword --silent
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Database connection successful!" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Database created but connection test failed" -ForegroundColor Yellow
        }
        
    } else {
        throw "MySQL command failed"
    }
} catch {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "    DATABASE SETUP FAILED!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please check:" -ForegroundColor Yellow
    Write-Host "1. MySQL server is running" -ForegroundColor Yellow
    Write-Host "2. Username and password are correct" -ForegroundColor Yellow
    Write-Host "3. You have permission to create databases" -ForegroundColor Yellow
    Write-Host "4. No firewall blocking MySQL connection" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Read-Host "Press Enter to exit" 