#!/bin/bash
# ---------------------------------------------------------------- #
# Script Name:   desafio4linux.sh
# Description:   Create 3 docker containers and do a reverse proxy with nginx.
# Linkedin:      www.linkedin.com/in/jonathan-abrantes-07614a48
# Written by:    Jonathan Abrantes
# Maintenance:   Jonathan Abrantes
# ---------------------------------------------------------------- #
##########IMPORTANTE########
#FAZER BACKUP DO ARQUIVO /ETC/HOSTS ANTES DE EXECUTAR O SCRIPT CASO O SEU ESTEJA CONFIGURADO MANUALMENTE
##########IMPORTANTE########
#Atualizando repositórios e instalando docker e nginx
sudo apt-get update
sudo apt-get install nginx docker.io -y
#Criando containers
sudo docker run -dit --name app1 -p 8080:80 httpd:2.4
sudo docker run -dit --name app2 -p 8081:80 httpd:2.4
sudo docker run -dit --name app3 -p 8082:80 httpd:2.4
#Adicionando pagina inicial nos 3 containers
sudo docker cp ./index1.html app1:/usr/local/apache2/htdocs/index.html
sudo docker cp ./index2.html app2:/usr/local/apache2/htdocs/index.html
sudo docker cp ./index3.html app3:/usr/local/apache2/htdocs/index.html
#Adicionando arquivos no diretório sites-available no nginx
sudo cp ./app1.4linux.local.com.br /etc/nginx/sites-available
sudo cp ./app2.4linux.local.com.br /etc/nginx/sites-available
sudo cp ./app3.4linux.local.com.br /etc/nginx/sites-available
#Criando link simbólico dos arquivos para o diretório sites-enabled
sudo ln -s /etc/nginx/sites-available/app1.4linux.local.com.br /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/app2.4linux.local.com.br /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/app3.4linux.local.com.br /etc/nginx/sites-enabled/
#Fazendo check do nginx e restartando o serviço do nginx
sudo nginx -t
sudo systemctl restart nginx
#Adicionando linhas no arquivo hosts e fazendo backup do arquivo hosts anterior
sudo mv /etc/hosts /etc/hosts_old
sudo cp ./hosts /etc/hosts
