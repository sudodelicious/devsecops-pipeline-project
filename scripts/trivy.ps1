# Trivy scan of source folder
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "❌ Docker is not installed or not in PATH."
    exit 1
}

Write-Output "🔍 Running Trivy scan..."

docker run --rm -v "$PWD:/project" aquasec/trivy:latest \
    filesystem /project --severity HIGH,CRITICAL > ../trivy-results.txt

Write-Output "✅ Trivy scan complete. Output saved to ../trivy-results.txt"
