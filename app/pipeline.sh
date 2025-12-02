#!/bin/bash

echo "========================================="
echo "          FAKE WORKFLOW                  "  
echo "========================================="
echo ""
echo " Executando fake workflow..."

echo "========================================="
echo "           HADOLINT CHECK"
echo "========================================="
echo ""

echo " Executando análise do Dockerfile..."
docker run --rm -i hadolint/hadolint < Dockerfile


if [ $? -eq 0 ]; then
    echo "✅ hadolint check passou com sucesso!"
else
    echo ""
    echo "❌ hadolint check falhou"
    echo "⚠️  Existem pontos a serem corrigidos no Dockerfile, analise falhas no step anterior e check a documentação:"
    echo "📖 https://github.com/hadolint/hadolint?tab=readme-ov-file#rules"
    exit 1
fi

sleep 2

echo "========================================="
echo "           Trivy CHECK"
echo "========================================="
echo ""

echo " Executando análise do ..."
sleep 2

docker run --rm -v $(pwd):/project aquasec/trivy config /project

if [ $? -eq 0 ]; then
    echo "✅ Trivy check passou com sucesso!"
else
    echo ""
    echo "❌ Trivy check falhou"
    echo "⚠️  Existem pontos a serem corrigidos no Dockerfile, analise falhas no step anterior"
    exit 1
fi

echo "========================================="
echo "           Build"
echo "========================================="
echo ""

docker build -t  app:1.0 . 

