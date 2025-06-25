# Build and Deploy Script for BookingService
Write-Host "Building BookingService..." -ForegroundColor Green

# Set paths
$SRC_DIR = "src\java"
$BUILD_DIR = "build\web\WEB-INF\classes"
$LIB_DIR = "web\lib"
$WEB_DIR = "web"

# Create build directory if it doesn't exist
if (!(Test-Path $BUILD_DIR)) {
    New-Item -ItemType Directory -Path $BUILD_DIR -Force
}

# Create classpath
$classpath = @()
Get-ChildItem -Path $LIB_DIR -Filter "*.jar" | ForEach-Object { $classpath += $_.FullName }
$classpath += $BUILD_DIR
$classpathString = $classpath -join ";"

Write-Host "Classpath: $classpathString" -ForegroundColor Yellow

# Compile all Java files
Write-Host "Compiling Java files..." -ForegroundColor Green

# Compile Model classes first
$modelFiles = Get-ChildItem -Path "$SRC_DIR\Model" -Filter "*.java" -Recurse
foreach ($file in $modelFiles) {
    Write-Host "Compiling $($file.Name)..." -ForegroundColor Cyan
    javac -cp $classpathString -d $BUILD_DIR $file.FullName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error compiling $($file.Name)" -ForegroundColor Red
        exit 1
    }
}

# Compile DAO classes
$daoFiles = Get-ChildItem -Path "$SRC_DIR\DAO" -Filter "*.java" -Recurse
foreach ($file in $daoFiles) {
    Write-Host "Compiling $($file.Name)..." -ForegroundColor Cyan
    javac -cp $classpathString -d $BUILD_DIR $file.FullName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error compiling $($file.Name)" -ForegroundColor Red
        exit 1
    }
}

# Compile Controller classes
$controllerFiles = Get-ChildItem -Path "$SRC_DIR\Controller" -Filter "*.java" -Recurse
foreach ($file in $controllerFiles) {
    Write-Host "Compiling $($file.Name)..." -ForegroundColor Cyan
    javac -cp $classpathString -d $BUILD_DIR $file.FullName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error compiling $($file.Name)" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Compilation completed successfully!" -ForegroundColor Green

# Copy web files to build directory
Write-Host "Copying web files..." -ForegroundColor Green
Copy-Item -Path "$WEB_DIR\*" -Destination "build\web\" -Recurse -Force

Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "You can now deploy the application to your server." -ForegroundColor Yellow 