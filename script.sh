#!/bin/bash

# Função para instalar o Go
install_go() {
    # Baixar o arquivo de instalação do Go
    wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz

    # Extrair o arquivo baixado
    tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz

    # Adicionar o diretório bin do Go ao PATH
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    source ~/.bashrc

    # Limpar o arquivo de instalação baixado
    rm go1.17.2.linux-amd64.tar.gz

    echo "Go foi instalado com sucesso!"
}

# Verificar se o Go está instalado
if command -v go &> /dev/null; then
    echo "Go já está instalado."
else
    echo "Go não encontrado. Instalando..."
    install_go
fi

# Função para executar ou compilar um script Go
run_or_build_go_script() {
    if [ -z "$1" ]; then
        echo "Forneça o caminho do script Go como argumento."
        exit 1
    fi

    script_path=$1
    script_name=$(basename $script_path)
    script_name_without_extension="${script_name%.*}"

    if [ -f "$script_path" ]; then
        # Verificar se o script é um executável
        if [ -x "$script_path" ]; then
            ./$script_name
        else
            # Compilar o script Go
            go build -o $script_name_without_extension $script_path
            echo "Executável criado: ./$script_name_without_extension"
        fi
    else
        echo "O script Go não foi encontrado no caminho fornecido."
        exit 1
    fi
}

# Exemplo de uso
# run_or_build_go_script /caminho/para/seu/script.go
