#!/bin/bash

func_menu () {
echo -e "
#########################################################
#	Qual servidor deseja verificar?			#
#							#
#	##### SMTPS ##### 				#
#	1) Server1	2) Server2	3) Server3 4) IASRV2	#
#	0 --> SAIR					#
#########################################################

opção:"
read menu	
}

lista_servidores=( "0" teste1" "teste2" "teste3" "teste4" )
func_servidor () {
#echo $menu
fim=""
for menu in ${lista_servidores[$menu]}; do
echo $menu

	while [[ fim==0 ]]; do
					echo -e "O que deseja fazer?

	#################################################################		
	#	1) Verificar disco e quais pastas estão pesando		#
	#	2) Verificar memoria					#
	#	3) Verificar processos					#
	#	4) Verificar sistema operacional e arquitetura e kernel #
	#	0 --> SAIR 						#
	#################################################################" 													
					read acao_servidor
					case $acao_servidor in
						1) 
							echo -e "Verficando espaço em disco:\n"
							ssh root@$menu "df -h"
							echo -e "\n"
							echo -e "#################################################### \n\n"
							ssh root@$menu "du -shc /*"
							echo -e "\n\n"
							;;
						2)
							echo -e "Verificando memoria:"
							ssh root@$menu "free -mh"
							echo -e "\n\n"
							;;
						3)
							echo -e "Verificando processos:"
							ssh root@$menu "top -b -n 1 | head -n 20"
							echo -e "\n\n"
							;;
						4)
							echo -e "Verificando sistema operacional da maquina...\n"
							ssh root@$menu "cat /etc/*-release"
							echo -e "\n"
							echo -e "Processador:\n"
							ssh root@$menu "uname -p"
							echo -e "\n"
							echo -e "Kernel\n"
							ssh root@$menu "uname -r"
							echo -e "\n\n"
							;;

						
						0)
							echo -e "\n saindo do $menu"
							echo -e "\n\n"
							fim="0"
							sleep 1
							clear
							break
							;;

						*)
							
							echo -e "Opção inválida! \n"
							echo -e "Voltando ao menu! \n\n"
							;;

						
					esac
							
	done
done
}

while [[ fim==0 ]]; do
func_menu

if [[ $menu -gt 0 ]]; 
then
	func_servidor
else
	echo -e "Saindo do programa"
	sleep 1
	exit
	fim=0
	
	
fi

done

