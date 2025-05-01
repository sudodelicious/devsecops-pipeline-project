# Checkov scan for Ansible playbooks
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "❌ Docker is not installed or not in PATH."
    exit 1
}

Write-Output "🔍 Running Checkov scan on Ansible directory..."

docker run --rm -v "$PWD:/ansible" bridgecrew/checkov:latest \
    -d /ansible --framework ansible --quiet > ../checkov-results.txt

Write-Output "✅ Checkov scan complete. Output saved to ../checkov-results.txt"
