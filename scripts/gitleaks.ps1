# Gitleaks secrets scan
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "❌ Docker is not installed or not in PATH."
    exit 1
}

Write-Output "🔍 Running Gitleaks secrets scan..."

docker run --rm -v "$PWD:/repo" zricethezav/gitleaks:latest \
    detect --source=/repo --no-banner --report-format=json \
    > ../gitleaks-results.txt

Write-Output "✅ Gitleaks scan complete. Output saved to ../gitleaks-results.txt"
