#!/bin/bash

echo "========================================="
echo "          FAKE WORKFLOW                  "  
echo "========================================="
echo ""
echo " Executando fake workflow..."

echo "========================================="
echo "           TFLINT CHECK"
echo "========================================="
echo ""

echo " Executando linter terraform..."
docker run --rm -v $(pwd):/data -t --entrypoint /bin/sh ghcr.io/terraform-linters/tflint -c "tflint --init && tflint --recursive"


if [ $? -eq 0 ]; then
    echo "✅ TFLINT check passou com sucesso!"
else
    echo ""
    echo "❌ TFLINT check falhou"
    echo ""
    echo "⚠️ Existem pontos a serem corrigidos no terraform, analise falhas no step anterior e check a documentação:"
    echo ""
    echo "📖 https://github.com/terraform-linters/tflint-ruleset-terraform/tree/v0.13.0/docs/rules"
    exit 1
fi

sleep 2

echo "========================================="
echo "           Terraform Format Check"
echo "========================================="
echo ""

terraform fmt -check -recursive

echo ""
echo "✅ Terraform formatado com sucesso!"
sleep 2
echo "========================================="    
echo "           Terraform Validate"
echo "========================================="
echo ""

terraform validate
if [ $? -eq 0 ]; then
    echo "✅ Terraform validate passou com sucesso!"
else
    echo ""
    echo "❌ Terraform validate falhou"
    echo ""
    echo "⚠️ Existem pontos a serem corrigidos no terraform"
    echo ""
    exit 1
fi

echo "========================================="    
echo "          Terraform Init          "
echo "========================================="
echo "" 
terraform init --upgrade

echo "========================================="    
echo "          Terraform Plan          "       
echo "========================================="
echo ""

terraform plan -out=plano.tfplan

echo "========================================="
echo "        Terraform Apply          "
echo "========================================="
echo ""

terraform apply -auto-approve plano.tfplan