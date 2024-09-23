#!/bin/bash

# Nome do arquivo de entrada contendo as variáveis
INPUT_FILE="secrets.txt"

# Função para converter valores em Base64
convert_to_base64() {
    echo -n "$1" | base64 | tr -d '\n'
}

# Ler cada linha do arquivo
while IFS= read -r line; do
    # Extrair chave e valor usando regex para valores entre aspas simples
    if [[ $line =~ ^([A-Z_]+)=[\'\"](.+)[\'\"]$ ]]; then
        key="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        
        # Converter o valor para Base64
        encoded_value=$(convert_to_base64 "$value")
        
        # Substituir '=' por ':' e imprimir no formato YAML
        echo "$key: $encoded_value"
    fi
done < "$INPUT_FILE"
