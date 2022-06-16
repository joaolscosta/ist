; *********************************************************************************
; * Identificação: GRUPO 13
; *				   Daniel Nunes ist1103095
; *                João Costa   ist1102078
; *                Luana Ferraz ist1102908
; * IST-UL
; * Modulo:    grupo13.asm
; * Descrição: Este programa consiste em realizar um jogo de simulação de um rover 
; * a defender um planeta. O rover obtém energia de meteoros bons e destroi os maus.
; * A interface é constítuida por um ecrã, um teclado e displays.
; *********************************************************************************
; * Constantes
; *********************************************************************************
DISPLAYS   				EQU 0A000H  	; endereço dos displays de 7 segmentos (periférico POUT-1)

TEC_LIN				    EQU 0C000H		; endereço das linhas do teclado 
TEC_COL				    EQU 0E000H		; endereço das colunas do teclado 

DEFINE_LINHA    		EQU 600AH      	; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU 600CH      	; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU 6012H      	; endereço do comando para escrever um pixel
COR_ATUAL				EQU 6010H		; endereço do comando que indica o endereço da cor do pixel na linha e coluna definidos

APAGA_TUDO 				EQU 6002H		; endereço do comando para apagar todos os pixeis do ecrã
APAGA_AVISO     		EQU 6040H      	; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRA	 		    EQU 6002H      	; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU 6042H      	; endereço do comando para selecionar uma imagem de fundo
TOCA_SOM				EQU 605AH      	; endereço do comando para tocar um som
TERMINA_SOM				EQU 6066H		; endereço do comando para terminar um som

MASCARA				    EQU 0FH			; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
PIN                     EQU 0E000H		; periférico de entrada de 8 bits

LINHA_TECLADO1			EQU 1			; linha a testar (1ª linha)
LINHA_TECLADO4			EQU 8			; linha a testar (4ª linha)

TECLA_ESQUERDA			EQU 1			; tecla na primeira coluna do teclado (tecla 0)
TECLA_DISPARO			EQU 2			; tecla na segunda coluna do teclado  (tecla 1)
TECLA_DIREITA			EQU 4			; tecla na terceira coluna do teclado (tecla 2)
TECLA_INICIO			EQU 1			; tecla na primeira coluna do teclado (tecla C)
TECLA_SUSPENDE			EQU 2			; tecla na segunda coluna do teclado  (tecla D)
TECLA_RETOMA			EQU 2			; tecla na segunda coluna do teclado  (tecla D)
TECLA_TERMINA			EQU 4			; tecla na terceira coluna do teclado (tecla E)

LINHA_ROVER        		EQU  28        	; linha do rover, quase no fim do ecrã
COLUNA_ROVER			EQU  30        	; coluna inicial do rover, a meio do ecrã
LINHA_MISSIL        	EQU  27        	; linha do inicial missil, quase no fim do ecrã
LINHA_INICIAL   		EQU  0			; linha do inicial do meteoro e das naves, no cimo do ecrã
COLUNA_METEORO  		EQU  15			; coluna do meteoro, à esquerda do ecrã
COLUNA_MEIO_MET			EQU  17			; coluna correspondente ao meio do meteoro
MIN_COLUNA				EQU  0			; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA				EQU  63        	; número da coluna mais à direita que o objeto pode ocupar
MAX_COLUNA_HEXA			EQU  3FH		; número da coluna mais à direita que o objeto pode ocupar em hexadecimal
ATRASO					EQU	 400H		; atraso para limitar a velocidade de movimento do rover
ULTIMA_LINHA			EQU	 32			; ultima linha que o meteoro atinge (fora dos limites do ecrã)

LARGURA_ROVER			EQU	5			; largura do rover
ALTURA_ROVER			EQU	4			; altura do rover
COR_PIXEL_ROVER1	  	EQU	0D58FH		; cor 1 do pixel do rover : azul claro em ARGB 
COR_PIXEL_ROVER2		EQU	0D0EFH		; cor 2 do pixel do rover: ciano em ARGB 
COR_PIXEL_ROVER3		EQU	0D08FH		; cor 3 do pixel do rover: azul escuro em ARGB 

LARGURA_MET		 		EQU 5			; largura do meteoro no seu tamanho máximo
ALTURA_MET_MIN			EQU 1			; altura minima do meteoro e das naves
ALTURA_MET_2			EQU 2			; altura do meteoro e das naves na fase 2 
ALTURA_MET_3			EQU 3			; altura do meteoro na fase 3
ALTURA_MET_4			EQU 4			; altura do meteoro na fase 4
ALTURA_MET_MAX 			EQU 5			; altura do meteoro no seu tamanho máximo
COR_METEORO				EQU 0F0B4H  	; cor do pixel do meteoro: verde em ARGB
COR_METEORO_MIN			EQU 0B444H		; cor do pixel do meteoro e das naves na fase inicial: cinzento em ARGB
COR_METEORO2			EQU 0B444H  	; cor do pixel do meteoro e das naves na fase 2: cinzento em ARGB  	

ALTURA_NAVE_3			EQU 3			; altura da nave na fase 3
ALTURA_NAVE_4			EQU 4			; altura da nave na fase 4
ALTURA_NAVE_MAX			EQU 5			; altura da nave no seu tamanho máximo
COR_NAVE1				EQU 0FF00H		; cor do pixel da nave 1: vermelho em ARGB
COR_NAVE2				EQU 0FF10H		; cor do pixel da nave 2: vermelho em ARGB
COR_NAVE3				EQU 0FF01H		; cor do pixel da nave 3: vermelho em ARGB

COR_MISSIL				EQU 0FD5DH		; cor do pixel do missil: roxo em ARGB

DIVISOR					EQU 10			; divisor utilizado para converter numeros hexadecimais em decimais
ALCANCE_MISSIL 			EQU 12			; alcance máximo do míssil
FATOR                   EQU 1000		; fator utilizado para converter numeros hexadecimais em decimais


; *********************************************************************************
; * Dados 
; *********************************************************************************
	
	PLACE 1000H

; Reserva do espaço para as pilhas dos processos
	STACK 100H				; espaço reservado para a pilha do processo "programa_principal"
SP_inicial_prog_princ:		; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H				; espaço reservado para a pilha do processo "loop_meteoro"
SP_inicial_meteoro:			; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H				; espaço reservado para a pilha do processo "disparo"
SP_inicial_disparo:			; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H				; espaço reservado para a pilha do processo "rover"
SP_inicial_rover:			; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H				; espaço reservado para a pilha do processo "energia_decrementa"
SP_inicial_energia:			; este é o endereço com que o SP deste processo deve ser inicializado


energia: 				WORD 64H	; variavel que guarda o valor da energia do rover

energia_inicial: 		WORD 64H	; variavel que guarda o valor da energia inicial do rover

energia_inicial_2: 		WORD 69H	; variavel que guarda o valor da energia inicial do rover mais 5 pois 
									; assim que o programa inicia a energia decrementa 5 

coluna_missil:			WORD 32		; variavel que guarda o valor da coluna onde o missil foi disparado, 
									; inicialmente onde o rover esta pocisionado antes de qualquer movimento

coluna_missil_aux:		WORD 32		; variavel auxiliar que guarda o valor da coluna onde o rover ficou no fim de cada movimento,
									; inicialmente onde o rover esta pocisionado antes de qualquer movimento

linha_missil:		    WORD 27		; variavel que guarda o valor da linha onde o missil está, 
									; inicialmente na linha onde vai estar quando for disparado que é sempre imediatamente a cima do rover

linha_atual_meteoro:	WORD 0		; variavel auxiliar utilizada nos diferentes metodos para ler a linha atual do meteoro com que estamos a trabalhar
linha_final_meteoro: 	WORD 1		; variavel auxiliar utilizada para guardar a linha imediatamente a baixo da linha em que o meteoro atual está
linha_final_meteoro1:   WORD 1		; variavel que guarda a linha imediatamente a baixo da linha em que a nave 1 está
linha_final_meteoro2:   WORD 1		; variavel que guarda a linha imediatamente a baixo da linha em que a nave 2 está
linha_final_meteoro3:   WORD 1		; variavel que guarda a linha imediatamente a baixo da linha em que a nave 3 está
linha_final_meteoro4:   WORD 1		; variavel que guarda a linha imediatamente a baixo da linha em que o meteoro está

coluna_atual_meteoro:  	WORD 0		; variavel auxiliar utilizada para guardar a coluna em que o meteoro atual está
coluna_atual_meteoro1: 	WORD 0		; variavel que guarda a coluna em que a nave 1 está
coluna_atual_meteoro2:	WORD 0		; variavel que guarda a coluna em que a nave 2 está
coluna_atual_meteoro3:	WORD 0		; variavel que guarda a coluna em que a nave 3 está
coluna_atual_meteoro4:  WORD 0		; variavel que guarda a coluna em que o meteoro está

coluna_atual_rover:	 	WORD 0		; variavel que guarda o valor da coluna em que o rover está

colidiu:    			WORD 0		; variavel que se a 1: indica que houve uma colisão, enquanto a 0: não há colisão

explodiu:    			WORD 0		; variavel que se a 1: indica que houve uma explusão, enquanto a 0: não há explusão

linha_missil_explosao:  WORD 0		; variavel que indica a linha onde o missil estava quando colidiu com um meteoro/nave 

coluna_missil_explosao: WORD 0		; variavel que indica a coluna onde o missil estava quando colidiu com um meteoro/nave

sub_met:				WORD 0		; variavel auxiliar para subtrair a linha de acordo com a fase em que o meteoro está

fase_meteoro: 			WORD 0		; variavel auxiliar que guarda o valor da fase do meteoro atual
fase_meteoro1: 			WORD 0		; variavel que guarda o valor da fase da nave 1
fase_meteoro2: 			WORD 0		; variavel que guarda o valor da fase da nave 2
fase_meteoro3: 			WORD 0		; variavel que guarda o valor da fase da nave 3
fase_meteoro4: 			WORD 0		; variavel que guarda o valor da fase do meteoro
fase_meteoro_atual:     WORD 0

vai_colidir:			WORD 0		; variavel que se a 1: indica que ao ser criado um meteoro/nave vai haver colisão entre eles

seleciona_meteoro:		WORD 0		; variavel auxiliar que enquanto a 1: indica que está selecionado o meteoro bom e as alterações são feitas nele

perdeu:					WORD 0		; variavel que quando a 1: indica que o jogador perdeu o jogo

colidiu_met: 			WORD 0		; variavel que quando a 1: indica que o meteoro colidiu com o missil ou o rover

seleciona_nave:			WORD 0		; variavel auxiliar que indica qual a nave selecionada, 1, 2 ou 3, com esses valores para cada uma respetivamente

nave_colidida:			WORD 0		; variavel auxiliar que no caso de haver colisao indica qual foi a nave colidida, 1, 2 ou 3

; tabela das rotinas de interrupção
BTE_START:
	WORD move_meteoro_interrupt 	; rotina de atendimento da interrupção 0
	WORD dispara_interrupt			; rotina de atendimento da interrupção 1
	WORD energia_interrupt    		; rotina de atendimento da interrupção 2		
	WORD 0


MOV_METEORO: WORD 0					; se 1, indica que a interrupção 0 ocorreu
DISPARA: WORD 0						; se 1, indica que a interrupção 1 ocorreu
ENERGIA: WORD 0						; se 1, indica que a interrupção 1 ocorreu


DEF_ROVER:			; tabela que define o rover (cor, largura, pixels)
	WORD			LARGURA_ROVER
	WORD			ALTURA_ROVER
	WORD			0, 0, COR_PIXEL_ROVER2, 0, 0
	WORD			COR_PIXEL_ROVER3, 0, COR_PIXEL_ROVER1, 0, COR_PIXEL_ROVER3
	WORD			COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1
	WORD        	COR_PIXEL_ROVER1, 0, 0, 0, COR_PIXEL_ROVER1	

DEF_METEORO_MIN:	; tabela que define o meteoro e os navas na fase inicial (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_MET_MIN
	WORD			0, 0, COR_METEORO_MIN, 0, 0

DEF_METEORO_2:		; tabela que define o meteoro e as naves na fase 2 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_MET_2
	WORD			0, COR_METEORO2, COR_METEORO2, 0, 0
	WORD			0, COR_METEORO2, COR_METEORO2, 0, 0

DEF_METEORO_3:		; tabela que define o meteoro bom na fase 3 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_MET_3
	WORD			0, 0, COR_METEORO, 0, 0
	WORD 			0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD			0, 0, COR_METEORO, 0, 0

DEF_METEORO_4:		; tabela que define o meteoro bom na fase 4 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_MET_4
	WORD			0, COR_METEORO, COR_METEORO, 0, 0
	WORD 			COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD 			COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD			0, COR_METEORO, COR_METEORO, 0, 0

DEF_METEORO_MAX:	; tabela que define o meteoro bom no seu tamanho maximo (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_MET_MAX
	WORD			0, 0, COR_METEORO, 0, 0
	WORD 			0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD 			COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO
	WORD 			0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD			0, 0, COR_METEORO, 0, 0

DEF_NAVE_3:			; tabela que define a nave 1 na fase 3 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_3
	WORD			0, COR_NAVE1, 0, COR_NAVE1, 0
	WORD 			0, 0, COR_NAVE1, 0, 0
	WORD			0, COR_NAVE1, 0, COR_NAVE1, 0

DEF_NAVE_4:			; tabela que define a nave 1 na fase 4 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_4
	WORD			COR_NAVE1, 0, COR_NAVE1, 0, COR_NAVE1
	WORD 			0, COR_NAVE1, COR_NAVE1, COR_NAVE1, 0
	WORD			0, COR_NAVE1, 0, COR_NAVE1, 0
	WORD        	0,0,0,0,0

DEF_NAVE_MAX:		; tabela que define a nave 1 no seu tamanho maximo (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_MAX
	WORD			COR_NAVE1, 0, COR_NAVE1, 0, COR_NAVE1
	WORD 			COR_NAVE1, 0, COR_NAVE1, 0, COR_NAVE1
	WORD			0, COR_NAVE1, COR_NAVE1, COR_NAVE1, 0
	WORD			0, COR_NAVE1, 0, COR_NAVE1, 0
	WORD			0, 0, COR_NAVE1, 0, 0

DEF_NAVE1_3:		; tabela que define a nave 2 na fase 3 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_3
	WORD			0, COR_NAVE2, 0, COR_NAVE2, 0
	WORD 			0, 0, COR_NAVE2, 0, 0
	WORD			0, COR_NAVE2, 0, COR_NAVE2, 0

DEF_NAVE1_4:		; tabela que define a nave 2 na fase 4 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_4
	WORD			COR_NAVE2, 0, COR_NAVE2, 0, COR_NAVE2
	WORD 			0, COR_NAVE2, COR_NAVE2, COR_NAVE2, 0
	WORD			0, COR_NAVE2, 0, COR_NAVE2, 0
	WORD        	0,0,0,0,0

DEF_NAVE1_MAX:		; tabela que define a nave 2 no seu tamanho máximo (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_MAX
	WORD			COR_NAVE2, 0, COR_NAVE2, 0, COR_NAVE2
	WORD 			COR_NAVE2, 0, COR_NAVE2, 0, COR_NAVE2
	WORD			0, COR_NAVE2, COR_NAVE2, COR_NAVE2, 0
	WORD			0, COR_NAVE2, 0, COR_NAVE2, 0
	WORD			0, 0, COR_NAVE2, 0, 0

DEF_NAVE2_3:		; tabela que define a nave 3 na fase 3 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_3
	WORD			0, COR_NAVE3, 0, COR_NAVE3, 0
	WORD 			0, 0, COR_NAVE3, 0, 0
	WORD			0, COR_NAVE3, 0, COR_NAVE3, 0

DEF_NAVE2_4:		; tabela que define a nave 3 na fase 4 (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_4
	WORD			COR_NAVE3, 0, COR_NAVE3, 0, COR_NAVE3
	WORD 			0, COR_NAVE3, COR_NAVE3, COR_NAVE3, 0
	WORD			0, COR_NAVE3, 0, COR_NAVE3, 0
	WORD        	0,0,0,0,0

DEF_NAVE2_MAX:		; tabela que define a nave 3 no seu tamanho maximo (largura, altura, cor e pixels)
	WORD			LARGURA_MET
	WORD			ALTURA_NAVE_MAX
	WORD			COR_NAVE3, 0, COR_NAVE3, 0, COR_NAVE3
	WORD 			COR_NAVE3, 0, COR_NAVE3, 0, COR_NAVE3
	WORD			0, COR_NAVE3, COR_NAVE3, COR_NAVE3, 0
	WORD			0, COR_NAVE3, 0, COR_NAVE3, 0
	WORD			0, 0, COR_NAVE3, 0, 0

DEF_EXPLOSAO:		; tabela que define a explosão quando há uma colisão (cor e pixels)
	WORD			COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD 			0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL
	WORD 			COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD 			0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL
	WORD			COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD			0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL


; *********************************************************************************
; * Código
; *********************************************************************************

PLACE   0                     			; o código tem de começar em 0000H
inicio:
	MOV  SP, SP_inicial_prog_princ		; inicializa SP para a palavra a seguir
						                ; à última da pilha   
	MOV  BTE, BTE_START					; inicializa BTE (registo de Base da Tabela de Exceções)

    MOV  [APAGA_AVISO], R1				; apaga o aviso de nenhum cenário selecionado
    MOV  [APAGA_ECRA], R1				; apaga todos os pixels já desenhados 

	CALL seleciona_cenario0				; seleciona o cenário inicial do jogo
	CALL toca_som4						; inicia o som de fundo do jogo	

espera_tecla_inicio:					; neste ciclo espera-se até a tecla de iniciar o jogo ser premida
	MOV  R6, LINHA_TECLADO4				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, TECLA_INICIO				; ve se a tecla premida é a tecla de inicio do jogo (tecla C)
	JNZ espera_tecla_inicio				; repete o ciclo se não for a tecla C
	CALL toca_som4						; toca o som de fundo do jogo
	
comeca_jogo:							; foi premida a tecla de inicio e o jogo começa
	CALL toca_som2						; toca o som de inicio de jogo
	CALL seleciona_cenario1				; seleciona o cenário do jogo
	MOV	 R7, 1							; valor a somar à coluna do rover, para o movimentar
	MOV  R9, [energia_inicial_2] 		; guarda o valor da energia inicial
	MOV  [energia], R9					; iniciar a energia a 100
 	MOV  R11, DISPLAYS  				; endereço do periférico dos displays
    CALL converte_numero				; converte o valor da energia de hexadecimal para decimal
	MOV  [R11], R9      				; escreve a energia do rover nos displays

posicao_rover:							; posiciona o rover na posição inicial
    MOV  R2, COLUNA_ROVER				; obtem a coluna inicial do rover
	MOV  [coluna_atual_rover], R2		; atualiza a variavel que guarda o valor da coluna em que o rover está
	MOV	 R4, DEF_ROVER					; endereço da tabela que define o rover
	CALL desenha_rover					; desenha o rover na posição inicial


posicao_meteoro:						; definir a posição inicial das naves e do meteoro 
	MOV R1, 1							; numero da nave
	MOV [seleciona_nave], R1			; seleciona a nave 1
    MOV  R1, LINHA_INICIAL				; linha inicial da nave
	CALL desenha_meteoro_inicial		; desenha a nave 1 na posição inicial
	PUSH R7
	MOV R7, [coluna_atual_meteoro]		; obtem o valor da coluna em que a nave 1 foi desenhada
	MOV [coluna_atual_meteoro1], R7 	; atualiza a variavel que guarda o valor da coluna da nave 1
	
	MOV R1, 2							; numero da nave
	MOV [seleciona_nave], R1			; seleciona a nave 2
	MOV R1, LINHA_INICIAL				; linha inicial da nave
	CALL desenha_meteoro_inicial		; desenha a nave 2 na posição inicial
	MOV R7, [coluna_atual_meteoro]		; obtem o valor da coluna em que a nave 2 foi desenhada
	MOV [coluna_atual_meteoro2], R7		; atualiza a variavel que guarda o valor da coluna da nave 2
	
	MOV R1, 3							; numero da nave
	MOV [seleciona_nave], R1			; seleciona a nave 3
	MOV R1, LINHA_INICIAL				; linha inicial da nave
	CALL desenha_meteoro_inicial		; desenha a nave 3 na posição inicial
	MOV R7, [coluna_atual_meteoro]      ; obtem o valor da coluna em que a nave 3 foi desenhada
	MOV [coluna_atual_meteoro3], R7		; atualiza a variavel que guarda o valor da coluna da nave 3
	
	MOV R1, 0							
	MOV [seleciona_nave], R1			; deixa de estar selecionada qualquer nave

	MOV R7, 1							
	MOV [seleciona_meteoro], R7			; seleciona o meteoro para as alterações ocorrerem nele
	MOV R1, LINHA_INICIAL				; linha inicial da nave
	CALL desenha_meteoro_inicial		; desenha o meteoro na posição inicial
	MOV R7, [coluna_atual_meteoro]		; obtem o valor da coluna em que o meteoro foi desenhado
	MOV [coluna_atual_meteoro4], R7		; atualiza a variavel que guarda o valor da coluna do meteoro
	MOV R7, 0
	MOV [seleciona_meteoro], R7			; deixa de estar selecionado o meteoro
	POP R7

inicio_processos: 						; permite as interrupções e inicia os processos
	EI0									; permite interrupções 0
	EI1 								; permite interrupções 1
	EI2 								; permite interrupções 1
	EI									; permite interrupções (geral)
			
	CALL loop_meteoro   				; inicia o processo que move o meteoro
	CALL disparo						; inicia o processo que dispara o missil
	CALL rover							; inicia o processo que move o rover
	CALL energia_decrementa			
			
programa_principal:						; processo que controla todo o programa
				
	YIELD			
			
	MOV R0, [perdeu]					; guaradar oo valor da variavel perdeu no registo R0
	CMP R0, 1							; verificar se o seu valor é um
	JZ  fim								; se for um o programa segue para o fim

	espera_tecla4:						; neste ciclo espera-se até uma tecla da linha 4 ser premida
		YIELD

		MOV R0, [perdeu]				; guaradar oo valor da variavel perdeu no registo R0
		CMP R0, 1						; verificar se o seu valor é um
		JZ  fim							; se for um o programa segue para o fim

		MOV R6, LINHA_TECLADO4			; linha a testar no teclado
		CALL teclado					; leitura às teclas
		CMP	 R0, 0
		JZ programa_principal			; nao houve uma tecla premida, volta ao inicio do programa principal
	
	suspende_jogo:						; verifica se a tecla premida é a de suspender o jogo (tecla D)
		CMP R0, TECLA_SUSPENDE
		JZ	espera_nao_tecla4			; pára o jogo
		

	termina_jogo:						; verifica se a tecla premida é a de terminar o jogo (tecla E)
		CMP R0, TECLA_TERMINA
		JZ	apaga_tudo					; o jogo terminou, vai apagar tudo
		JMP espera_tecla4				; o jogo nao terminou


	espera_nao_tecla4:					; neste ciclo espera-se até não estar premida alguma tecla da linha 4
		CALL seleciona_cenario3			; seleciona o cenario de pausa
		CALL teclado					; leitura às teclas
		CMP R0, 0							
		JZ disable						; como não há nenhuma tecla, suspende-se o jogo
		JMP espera_nao_tecla4			; continua no ciclo pois nao foi premida a tecla para recomeçar o jogo

	apaga_tudo:							; apaga todo o conteudo do ecrã
		MOV  [APAGA_TUDO], R1			; apaga todos os pixeis do ecrã
		CALL seleciona_cenario2			; seleciona o cenario de termino do jogo
		CALL termina_som4				; termina a reprodução do som de fundo do jogo
		CALL toca_som1					; reproduz o som de termino de jogo
		JMP fim							; vai para o ciclo de fim de jogo

	apaga_tudo2:						; apaga todo o conteudo do ecrã
		MOV  [APAGA_TUDO], R1			; apaga todos os pixeis do ecrã
		CALL seleciona_cenario4			; seleciona o cenario correspondente à explosao do rover
		CALL termina_som4				; termina a reprodução do som de fundo do jogo

	fim:								; inicia todas as variaveis com os valores iguais aquando do inicio do jogo
		PUSH R9
		MOV R9, 0
		MOV [nave_colidida], R9
		MOV [seleciona_nave], R9
		MOV [perdeu], R9
		MOV [linha_atual_meteoro], R9
		MOV [colidiu], R9
		MOV [explodiu], R9
		MOV [linha_missil_explosao], R9
		MOV [coluna_missil_explosao], R9
		MOV [sub_met], R9
		MOV [fase_meteoro], R9
		MOV [fase_meteoro1], R9
		MOV [fase_meteoro2], R9
		MOV [fase_meteoro3], R9
		MOV [fase_meteoro4], R9
		MOV [vai_colidir], R9
		MOV [seleciona_meteoro], R9
		MOV [coluna_atual_rover], R9
		INC R9
		MOV [linha_final_meteoro], R9
		MOV [linha_final_meteoro1], R9
		MOV [linha_final_meteoro2], R9
		MOV [linha_final_meteoro3], R9
		MOV [linha_final_meteoro4], R9
		MOV R9, 64H
		MOV [energia], R9
		MOV [energia_inicial], R9
		MOV R9, 69H
		MOV [energia_inicial_2], R9
		MOV R9, 32
		MOV [coluna_missil], R9
		MOV [coluna_missil_aux], R9
		MOV R9, 27
		MOV [linha_missil], R9

		POP R9					
		DI									; desliga todas as interrupções
		
		MOV  SP, SP_inicial_prog_princ		; inicializa SP para a palavra a seguir
						                	; à última da pilha   
		MOV  BTE, BTE_START					; inicializa BTE (registo de Base da Tabela de Exceções)
		JMP espera_tecla_inicio				; vamos esperar que seja premida a tecla que inicia o jogo

	disable:								; desliga as interrupções
		DI

	jogo_suspenso:							; espera até que a tecla premida seja a de continuar o jogo (tecla D)
		CALL teclado						; leitura às teclas
		CMP R0, TECLA_RETOMA				; verifica se a tecla premida é a tecla de retomar om jogo
		JNZ	jogo_suspenso					; enquanto nao for, o jogo continua suspenso				
	
	retoma_enable:							; volta a ligar as interrupções
		CALL seleciona_cenario1
		EI
	
	espera_nao_tecla_suspensa:				; neste ciclo espera-se até não estar premida a tecla de retomar o jogo
		CALL teclado						; leitura às teclas
		CMP R0, 0
		JZ espera_tecla4					; como a tecla não está premida, retoma-se o jogo
		JMP espera_nao_tecla_suspensa		; enquanto a tecla estiver premida o jogo nao avança
		
	JMP programa_principal					; volta ao inicio do programa principal

PROCESS SP_inicial_rover

rover:										; neste ciclo espera-se até uma tecla ser premida

	YIELD

	MOV R0, [perdeu]						; guaradar oo valor da variavel perdeu no registo R0
	CMP R0, 1								; verificar se o seu valor é um
	JZ  fim									; se for um o programa segue para o fim

	MOV  R6, LINHA_TECLADO1					; linha a testar no teclado
	CALL teclado							; leitura às teclas
	CMP	 R0, 0
	JZ rover								; se nao for premida nenhuma tecla da linha 1 volta ao inicio do ciclo

ha_tecla:									; vê se é para deslocar o rover para a esquerda ou direita
	CALL atraso								; atraso para limitar a velocidade do rover
	CMP	 R0, TECLA_ESQUERDA				
	JNZ	 testa_direita						; se não for a tecla da esquerda vê se é a da direita
	MOV	 R7, -1								; vai deslocar para a esquerda
	JMP	 ve_limites							; vai verificar se o objeto está ou não nos limites do ecrã

testa_direita:
	CMP	 R0, TECLA_DIREITA
	JNZ	 rover								; caso em que não move o rover, volta ao ciclo
	MOV	 R7, +1								; vai deslocar para a direita
	
ve_limites:									; verifica se o objeto está ou não nos limites do ecrã
	MOV	 R6, [R4]							; obtém a largura do rover
	CALL testa_limites						; vê se chegou aos limites do ecrã e se sim força R7 a 0
	CMP	 R7, 0							
	JZ	 rover								; se não é para movimentar o objeto, volta ao ciclo

move_rover:									; vai mover o rover para a esquerda ou direita
	MOV R2, [coluna_atual_rover]			; guarda o valor da coluna do ultimo movimento do rover no registo R2
	PUSH R1
	MOV  R4, DEF_ROVER						; seleciona a tabela que corresponde ao formato do rover
	CALL apaga_rover						; apaga o rover na sua posição corrente
	
coluna_seguinte:							; para desenhar o rover na coluna seguinte (direita ou esquerda)
	ADD	R2, R7									
	ADD R2, 2								; seleciona a coluna do meio do rover
	MOV [coluna_missil_aux], R2				; guarda o valor da coluna do meio do rover para o usar se disparar o missil
	SUB R2, 2								; repôem o valor da coluna do rover
	JMP	mostra_rover						; vai desenhar o rover de novo
	POP R1

mostra_rover:								; vai desenhar o rover na nova coluna
	MOV	 R4, DEF_ROVER						; seleciona a tabela que corresponde ao formato do rover
	CALL desenha_rover						; desenha o rover a partir da tabela e coluna indicadas
	MOV [coluna_atual_rover], R2			; atualiza o valor da coluna do rover
	JMP rover								; volta ao ciclo inicial do rover


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PROCESS SP_inicial_meteoro

loop_meteoro:								; ciclo inicial do processo que verifica se houve alguma explosão
	PUSH R7
	MOV R7, [explodiu]						; guarda o valor da variavel no registo R7
	CMP R7, 1
	JNZ loop_meteoro2						; se a variavel for zero é porque não houve explosão anteriormente
	MOV R7, 0
	MOV [explodiu], R7						; repoe o valor da variavel
	CALL atraso								; atraso que permite não apagar a explosão de imediato
	CALL apaga_explosao						; vai apagar a explosão desenhada anteriormente

loop_meteoro2:								; segundo ciclo do processo que controla os movimentos do meteoro e das naves				
	POP R7
	YIELD	

	MOV R0, [perdeu]						; guaradar o valor da variavel perdeu no registo R0
	CMP R0, 1								; verificar se o seu valor é um
	JZ  rover									; se for um o programa segue para o fim

	MOV R0, [MOV_METEORO]					; verifica se o processo de movimento já foi executado
	CMP R0, 0
	JZ loop_meteoro							; se já foi executado volta ao inicio do processo

	MOV R0, 0
	MOV [MOV_METEORO], R0					; repõe o valor que controla a execução do movimento 

	PUSH R7

	
	MOV R1, 1								; numero da nave
	MOV [seleciona_nave], R1				; seleciona a nave 1

	MOV  R1, [linha_final_meteoro1]			; guarda no registo R1 a linha final da nave correspondente
	MOV R7, [coluna_atual_meteoro1]			; guarda no registo R7 a coluna final da nave correspondente
	MOV [coluna_atual_meteoro], R7			; atualiza a coluna atual da nave
	MOV R7, [fase_meteoro1]					; guarda no registo R7 o valor da fase em que a nave está
	MOV [fase_meteoro], R7					; atualiza a fase do nave
	POP R7
	
	CALL move_meteoro						; vai mover a nave

	MOV  [linha_final_meteoro1], R1			; atualiza o valor da linha final da nave correspondente
	PUSH R7
	MOV R7, [coluna_atual_meteoro]			; atualiza o valor da coluna atual da nave
	MOV [coluna_atual_meteoro1], R7			; atualiza o valor da coluna final da nave correspondente
	MOV R7, [fase_meteoro]					
	MOV [fase_meteoro1], R7					; atualiza o valor da fase da nave correspondente


	MOV R1, 2								; numero da nave
	MOV [seleciona_nave], R1				; seleciona a nave 2

	MOV  R1, [linha_final_meteoro2]			; guarda no registo R1 a linha final da nave correspondente
	MOV R7, [coluna_atual_meteoro2]			; guarda no registo R7 a coluna final da nave correspondente
	MOV [coluna_atual_meteoro], R7			; atualiza a coluna atual da nave
	MOV R7, [fase_meteoro2]					; guarda no registo R7 o valor da fase em que a nave está
	MOV [fase_meteoro], R7					; atualiza a fase da nave
	POP R7
	
	CALL move_meteoro						; vai mover a nave
	
	MOV  [linha_final_meteoro2], R1			; atualiza o valor da linha final da nave correspondente
	PUSH R7
	MOV R7, [coluna_atual_meteoro]			; atualiza o valor da coluna atual da nave
	MOV [coluna_atual_meteoro2], R7			; atualiza o valor da coluna final da nave correspondente
	MOV R7, [fase_meteoro]
	MOV [fase_meteoro2], R7					; atualiza o valor da fase da nave correspondente


	MOV R1, 3								; numero da nave
	MOV [seleciona_nave], R1				; seleciona a nave 3

	MOV  R1, [linha_final_meteoro3]			; guarda no registo R1 a linha final da nave correspondente
	MOV R7, [coluna_atual_meteoro3]			; guarda no registo R7 a coluna final da nave correspondente
	MOV [coluna_atual_meteoro], R7			; atualiza a coluna atual da nave
	MOV R7, [fase_meteoro3]					; guarda no registo R7 o valor da fase em que a nave está
	MOV [fase_meteoro], R7					; atualiza a fase da nave
	POP R7

	CALL move_meteoro						; vai mover a nave
	
	MOV  [linha_final_meteoro3], R1			; atualiza o valor da linha final da nave correspondente
	PUSH R7
	MOV R7, [coluna_atual_meteoro]			; atualiza o valor da coluna atual da nave
	MOV [coluna_atual_meteoro3], R7			; atualiza o valor da coluna final da nave correspondente
	MOV R7, [fase_meteoro]
	MOV [fase_meteoro3], R7					; atualiza o valor da fase da nave correspondente

	
	MOV R1, 0								; numero do meteoro 
	MOV [seleciona_nave], R1				; seleciona o meteoro

	MOV R7, 1
	MOV [seleciona_meteoro], R7				; indica que vamos mover o meteoro

	MOV  R1, [linha_final_meteoro4]			; guarda no registo R1 a linha final do meteoro 
	MOV R7, [coluna_atual_meteoro4]			; guarda no registo R7 a coluna final do meteoro 
	MOV [coluna_atual_meteoro], R7			; atualiza a coluna atual do meteoro
	MOV R7, [fase_meteoro4]					; guarda no registo R7 o valor da fase em que o meteoro está
	MOV [fase_meteoro], R7					; atualiza a fase do meteoro
	POP R7
	
	CALL move_meteoro						; vai mover o meteoro
	
	MOV  [linha_final_meteoro4], R1			; atualiza o valor da linha final do meteoro 
	PUSH R7
	MOV R7, [coluna_atual_meteoro]			; atualiza o valor da coluna atual do meteoro
	MOV [coluna_atual_meteoro4], R7			; atualiza o valor da coluna final do meteoro 
	MOV R7, [fase_meteoro]
	MOV [fase_meteoro4], R7					; atualiza o valor da fase do meteoro 

	MOV R7, 0
	MOV [seleciona_meteoro], R7				; repõe a indicação de movimento do meteoro
	POP R7

novo_loop:	
	JMP loop_meteoro						; volta ao inicio do ciclo


PROCESS SP_inicial_disparo

disparo:									; verifica se a tecla premida é a do disparo (tecla 1)
	YIELD	

	MOV R0, [perdeu]						; obtém o estado do jogo 
	CMP R0, 1								; verificamos se perdemos o jogo
	JZ  novo_loop							; se acontecer a comparação anterior, inicia-se um novo loop do meteoro

	MOV R6, LINHA_TECLADO1					; linha a testar no teclado
	CALL teclado							; leitura às teclas
	CMP	 R0, 0								; compara a conjunção entre a coluna do teclado e a máscara 
	JZ 	disparo								; repete de novo o ciclo se forem diferentes


disparo2:									; inicia o ciclo de disparo
	CMP R0, TECLA_DISPARO					; verifica se a tecla premida é a tecla de disparo ( 1 )
	JNZ disparo_ret							; se não for essa a tecla sai do ciclo
	CALL decrementa							; se for a tecla de disparo premida então chama este método para efetuar o decremento da energia
	CALL toca_som6							; reproduz o som de disparo do míssil efetuado pelo rover
	PUSH R7	
	MOV R7, LINHA_MISSIL					; obter a linha inicial onde é disparo o míssil
	MOV [linha_missil], R7					; guardar em memória qual a linha em que está o míssil de momento
	MOV R7, [coluna_missil_aux]				; lê qual a coluna onde míssil esteve
	MOV [coluna_missil], R7					; escreve a nova posição do míssil
	POP R7		
	CALL desenha_missil						; método para obter as novas características do míssil
	MOV R9, 0								; inicia a linha do míssil para a primeira linha
	MOV R7, ALCANCE_MISSIL							; inicia a linha do míssil para a primeira linha	
	JMP loop_missil							; se não tivermos desenhado o míssil vamos percorrer o loop do míssil

disparo_ret:							
	JMP disparo

desenha_missil:
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R1, [linha_missil]					; obtém a linha em que o míssil está	
	MOV R2, [coluna_missil]					; obtém a coluna em que o míssil está
	MOV R3, COR_MISSIL						; obtém a cor do míssil	
	CALL escreve_pixel_missil				; ciclo para escrever o míssil no ecrã na sua nova posição
	POP R3
	POP R2
	POP R1
	RET

move_missil:
	PUSH R1
    PUSH R2
	PUSH R7
    MOV  R1, [linha_missil]					; obtém a linha em que o míssil está
	MOV  R2, [coluna_missil]            	; obtém a coluna em que o míssil está
    CALL apaga_missil                   	; antes de mover temos que apagar o míssil
	MOV R7, [linha_missil]					; obtém a linha em que o míssil está
	DEC R7									; decrementa a linha do míssil para a próxima posição
	MOV [linha_missil], R7					; escreve em memória a nova linha onde o míssil será desenhado no próximo ciclo
	CALL desenha_missil						; método para obter as novas características do míssil
	POP R7
	POP R2
	POP R1
	RET

apaga_missil:
	PUSH R3
	MOV R3, 0								; atualizamos o registo para ficar sem cor
	CALL escreve_pixel						; apaga todos os pixeis com a cor vazia
	POP R3	
	RET	

loop_missil:	
	YIELD	

	MOV R0, [perdeu]						; obtém o estado do jogo
	CMP R0, 1								; verificamos se perdemos o jogo
	JZ  disparo								; ciclo para efetuar o disparo do míssil se não tiver terminado o jogo

	MOV R0, [DISPARA]						; verifica se a interrupção de disparo acontece ou não
	CMP R0, 0								
	JZ loop_missil							; se não acontecer vai-se dar o próximo ciclo do míssil a mover-se

	MOV R0, 0								
	MOV [DISPARA], R0						; desligamos a interrupção do disparo

	CALL move_missil						; movemos o míssil para a próxima posição
	INC R9									; incrementa a linha do míssil
	CMP R9, R7								; verifica se chegámos à última linha 
	JNZ loop_missil							; se não tiver atingido a última linha executa uma vez mais o loop do míssil
	PUSH R1	
	PUSH R2	
	MOV  R1, [linha_missil]					; obtém a linha em que está o míssil
	MOV  R2, [coluna_missil]            	; obtém a coluna em que está o míssil
	CALL apaga_missil						; míssil chega à última linha sem colidir com nada e apenas queremos apagá-lo
	POP R2	
	POP R1	
	JMP disparo_ret							; saímos do ciclo do míssil


PROCESS SP_inicial_energia	

energia_decrementa:							; processo para decrementar a energia
	YIELD	

	MOV R0, [perdeu]						; obtém o estado do jogo
	CMP R0, 1								; verificamos se perdemos o jogo
	JZ  loop_missil							; se acontecer vai-se dar o próximo ciclo do míssil a mover-se

	MOV R0, [ENERGIA]						; verificamos se a interrupção da energia está a acontecer
	CMP R0, 0								
	JZ energia_decrementa					; se não estiver ligada este método repete-se

	MOV R0, 0								 
	MOV [ENERGIA], R0						; desligamos a interrupção


	CALL decrementa							; decrementa o valor da energia no display
	JMP energia_decrementa					; repete-se o método

decrementa:                             	; decrementa valor do display
    PUSH R9                             	
    MOV R9, [energia]                   	; guarda o valor atual da energia num registo
    SUB R9, 5                           	; decrementa o valor da energia em 5    
    MOV [energia], R9                   	; altera o valor da energia depois da decrementação
    CALL converte_numero                	; vai converter o numero hexadecimal em decimal
    MOV [R11], R9                       	; escreve o valor no display
    CMP R9, 0	
    JNZ nao_perde                       	; a energia nao ficou a zero, logo o jogo nao vai acabar
    CALL perde_jogo                     	; a energia do rover chegou a zero
    RET

nao_perde:
    POP R9                              
    RET             

perde_jogo:
    POP R9
    CALL toca_som5                      	; toca o som de ter perdido o jogo
    JMP apaga_tudo2                     	; vai apagar todo o conteudo ecrã
    RET	

incrementa:                             	; incrementa o valor do display
    PUSH R3                             	
    PUSH R9	
    MOV R3, [explodiu]                  	
    CMP R3, 1                           	; verifica se houve alguma explosão
    JZ nao_incrementa                   	; se houve, não vai incrementar
    MOV R3, [energia_inicial]           	; guarda o valor inicial que é o maximo da energia          
    MOV R9, [energia]                   	; guarda o valor atual da energia num registo
    ADD R9, R7                          	; adiciona o valor indicado antes de chamar "incrementa", à energia
    CMP R9, R3                          	; verifica se a energia for aumentada, ultrapassa a energia máxima
    JGT nao_incrementa                  	; nao incrementa se ultrapassar a energia maxima
    MOV R3, ULTIMA_LINHA	
    CMP R1, R3	
    JZ  nao_incrementa                  	; nao incrementa se o meteoro estiver na ultima linha
    CALL toca_som3                      	; toca o som de incrementação da energia do rover
    MOV [energia], R9                   	; altera o valor da energia depois da incrementação
    CALL converte_numero                	; converte um numero hexadecimal em decimal
    MOV [R11], R9                       	; escreve o valor no display

nao_incrementa:                         	; nao incrementa a energia
    MOV R3, 0	
    MOV [explodiu], R3                  	; repõe o valor da variavel que indica se houve explosão
    POP R9
    POP R3
    RET

; **********************************************************************
; DESENHA_ROVER - Desenha o Rover no centro do ecra com a forma e cor 
;                 definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o rover
;
; **********************************************************************

desenha_rover:
	PUSH R1
	MOV  R1, LINHA_ROVER	  				; o valor anterior de R1 é a linha do meteoro
	PUSH R2				
	PUSH R3				
	PUSH R4				
	PUSH R5				
	PUSH R8				
	PUSH R10				
	MOV	 R5, [R4]		      				; obtém a largura do rover
	ADD  R4, 2				  				; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]            				; obtém a altura do rover
	ADD	 R4, 2			      				; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2				  				; guarda a coluna atual
	MOV  [coluna_atual_rover], R2     		; o valor anteior de R2 é a coluna do Rover

desenha_pixels_rover:      	  				; desenha os pixels do rover a partir da tabela
	MOV	 R3, [R4]			  				; obtém a cor do próximo pixel do rover
	CALL escreve_pixel		  				; escreve cada pixel do rover
	ADD	 R4, 2			      				; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                				; próxima coluna
	SUB  R5, 1 		          				; menos uma coluna para tratar
	JNZ  desenha_pixels_rover 				; continua até percorrer toda a largura do rover
	ADD  R1, 1				  				; proxima linha
    MOV  R2, [coluna_atual_rover]			; repor o valor da coluna inicial
	MOV  R2, R8
    MOV  R5, LARGURA_ROVER	 				; repor a largura do rover para a proxima coluna
	SUB  R10, 1				 				; menos uma linha para tratar
    JNZ  desenha_pixels_rover				; continua até percorrer toda a altura do objeto
	POP	 R10
	POP  R8
	POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
	POP  R1
	RET

; **********************************************************************
; APAGA_ROVER - Apaga o Rover com a forma definida na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o rover
;
; **********************************************************************

apaga_rover:
	PUSH R1
	MOV  R1, LINHA_ROVER					; o valor anterior de R1 é a linha do meteoro
	PUSH R2				
	PUSH R3				
	PUSH R4				
	PUSH R5				
	PUSH R8				
	PUSH R10				
	MOV	 R5, [R4]		    				; obtém a largura do rover
	ADD  R4, 2								; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]          				; obtém a altura do rover
	ADD	 R4, 2			    				; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2								; guarda a coluna atual

apaga_pixels_rover:         				; desenha os pixels do rover a partir da tabela
	MOV	 R3, 0								; cor para apagar o próximo pixel do rover
	CALL escreve_pixel						; escreve cada pixel do rover
	ADD	 R4, 2								; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1              				; próxima coluna
    SUB  R5, 1								; menos uma coluna para tratar
    JNZ  apaga_pixels_rover 				; continua até percorrer toda a largura do objeto
	ADD  R1, 1								; proxima linha
    MOV  R2, R8								; repor o valor da coluna inicial
	MOV  R5, LARGURA_ROVER					; repor a largura do rover para a proxima coluna
	SUB  R10, 1								; menos uma linha para tratar
    JNZ  apaga_pixels_rover 				; continua até percorrer toda a altura do rover
	POP  R10
	POP  R8
	POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
	POP  R1
	RET


; **********************************************************************
; DESENHA_METEORO - Desenha o Meteoro com a forma e cor 
;                 definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o meteoro
;
; **********************************************************************
desenha_meteoro_inicial:

	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	PUSH R9
	PUSH R7
	MOV  R7, 1
	MOV  [sub_met], R7
	MOV [fase_meteoro], R7
	POP R7
	MOV R4, DEF_METEORO_MIN
	JMP gera_aleatoriamente

gera_aleatoriamente_pop:
	MOV R7, 0
	MOV [vai_colidir], R7
	POP R7

gera_aleatoriamente:
	MOV R9, [PIN]
	SHR R9, 5
	CALL subtrair_64
	PUSH R7
	PUSH R6
	PUSH R5
	PUSH R9
	PUSH R8
	MOV R8, R9
	MOV R6, 0
	MOV R5,0
	CALL limites_novo_direita
	POP R8
	POP R9
	PUSH R9
	PUSH R8
	MOV R8, R9
	MOV R6, 7
	MOV R5, 7
	CALL limites_novo_esquerda
	POP R8
	POP R9
	POP R5
	POP R6
	MOV R7, [vai_colidir]
	CMP R7, 1
	JZ gera_aleatoriamente_pop
	POP R7
	MOV  R5, [R4]                ; obtém a largura do meteoro
	ADD  R4, 2                    ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]              ; obtém a altura do meteoro
	ADD  R4, 2                    ; endereço da cor do 1º pixel (2 porque a largura é uma word)
	;MOV  R8, R9                ; guardar o valor da coluna atual
	MOV [coluna_atual_meteoro], R9
	MOV R2, R9
	POP R9
	PUSH R1
	;MOV  [linha_atual_meteoro], R1
	POP  R1
	JMP desenha_pixels_meteoro

desenha_meteoro:
	PUSH R2
	MOV  R2, [coluna_atual_meteoro]     ; o valor anteior de R2 é a coluna do Rover
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	PUSH R7

	MOV  R7, [fase_meteoro]
	CMP  R7, 3
	JLT  continua_desenha_min

	CMP  R7, 6
	JLT  continua_desenha2

	PUSH R9
	MOV  R9, 9
	CMP  R7, R9
	JLT  continua_desenha3

	MOV  R9, 12
	CMP  R7, R9
	JLT  continua_desenha4

	POP  R9
	JMP  continua_desenha_max

continua_desenha_min:
	SUB R1, 1
	MOV  R7, 1
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_MIN
	JMP  continua_desenha					; guardar o valor da coluna atual
continua_desenha2:
	SUB R1, 2
	MOV  R7, 2
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_2
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha3:
	SUB R1, 3
	POP  R9
	MOV  R7, 3
	MOV  [sub_met], R7
	MOV R7, [seleciona_meteoro]
	CMP R7, 1
	JZ continua_desenha3_met

seleciona_nave_desenhar:
	PUSH R9
	MOV R7, 1
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave1_fase3
	MOV R7, 2
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave2_fase3
	MOV R7, 3
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave3_fase3

desenha_nave1_fase3:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE_3
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave2_fase3:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE1_3
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave3_fase3:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE2_3
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha3_met:
	POP  R7
	MOV  R4, DEF_METEORO_3
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha4:
	SUB R1, 4
	POP  R9
	MOV  R7, 4
	MOV  [sub_met], R7
	MOV R7, [seleciona_meteoro]
	CMP R7, 1
	JZ continua_desenha4_met
	;POP  R7
	;MOV  R4, DEF_NAVE_4
	;JMP  continua_desenha					; guardar o valor da coluna atual		

seleciona_nave_desenhar_fase4:
	PUSH R9
	MOV R7, 1
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave1_fase4
	MOV R7, 2
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave2_fase4
	MOV R7, 3
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave3_fase4

desenha_nave1_fase4:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE_4
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave2_fase4:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE1_4
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave3_fase4:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE2_4
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha4_met:
	POP  R7
	MOV  R4, DEF_METEORO_4
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha_max:
	SUB R1, 5
	MOV  R7, 5
	MOV  [sub_met], R7
	MOV R7, [seleciona_meteoro]
	CMP R7, 1
	JZ continua_desenha_max_met

	;POP  R7
	;MOV  R4, DEF_NAVE_MAX
	;JMP continua_desenha

seleciona_nave_desenhar_fase5:
	PUSH R9
	MOV R7, 1
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave1_fase5
	MOV R7, 2
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave2_fase5
	MOV R7, 3
	MOV R9, [seleciona_nave]
	CMP R7, R9
	JZ desenha_nave3_fase5

desenha_nave1_fase5:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE_MAX
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave2_fase5:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE1_MAX
	JMP  continua_desenha					; guardar o valor da coluna atual

desenha_nave3_fase5:
	POP  R9
	POP  R7
	MOV  R4, DEF_NAVE2_MAX
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha_max_met:
	POP  R7
	MOV  R4, DEF_METEORO_MAX
	JMP  continua_desenha					; guardar o valor da coluna atual

continua_desenha:
	MOV	 R5, [R4]		        ; obtém a largura do meteoro
	ADD  R4, 2				    ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]              ; obtém a altura do meteoro
	ADD	 R4, 2			        ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    ;MOV  R8, R2					; guardar o valor da coluna atual
	PUSH R1
	MOV  [linha_atual_meteoro], R1
	POP  R1

desenha_pixels_meteoro:         ; desenha os pixels do meteoro a partir da tabela
	MOV	 R3, [R4]			    ; obtém a cor do próximo pixel do meteoro
	CALL escreve_pixel_met		; escreve cada pixel do meteoro
	ADD	 R4, 2			        ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                  ; próxima coluna
	SUB  R5, 1 		            ; menos uma coluna para tratar
	JNZ  desenha_pixels_meteoro ; continua até percorrer toda a largura do meteoro
	ADD  R1, 1					; proxima linha
    MOV  R2, [coluna_atual_meteoro]					; repor o valor da coluna inicial
    MOV  R5, LARGURA_MET		; repor a largura do meteoro para a proxima coluna
	SUB  R10, 1				    ; menos uma linha para tratar
    JNZ  desenha_pixels_meteoro ; continua até percorrer toda a altura do meteoro
	POP	 R10
	POP  R8
	POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
	RET

; **********************************************************************
; APAGA_METEORO - Apaga o Meteoro com a forma definida na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o meteoro
;
; **********************************************************************

apaga_meteoro:
	PUSH R1
	PUSH R2
	MOV  R2, [coluna_atual_meteoro]   ; obtém o valor da coluna em que o meteoro/nave está
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	PUSH R7
	MOV  R7, [fase_meteoro]			  ; obtém em que fase está o meteoro/nave 
	INC  R7							  ; passa o meteoro/nave para a próxima fase
	CMP  R7, 3						  ; verifica se já se efetuaram 3 movimentos por parte do meteoro/nave
	JLT  continua_apaga_min			  ; se não tiverem ocorridos 3 movimentos apenas apaga o meteoro/nave e passa para a próxima posição sem alterar a fase
	CMP  R7, 6						  ; verifica se já se efetuaram 6 movimentos por parte do meteoro/nave
	JLT  continua_apaga2			  ; se não tiverem ocorridos 6 movimentos apenas apaga o meteoro/nave e passa para a próxima posição sem alterar a fase
	PUSH R9
	MOV  R9, 9						  ; verifica se já se efetuaram 9 movimentos por parte do meteoro/nave
	CMP  R7, R9
	JLT  continua_apaga3			  ; se não tiverem ocorridos 9 movimentos apenas apaga o meteoro/nave e passa para a próxima posição sem alterar a fase
	MOV  R9, 12						  ; verifica se já se efetuaram 12 movimentos por parte do meteoro/nave
	CMP  R7, R9
	JLT  continua_apaga4			  ; se não tiverem ocorridos 12 movimentos apenas apaga o meteoro/nave e passa para a próxima posição sem alterar a fase
	POP  R9
	JMP  continua_apaga_max			  ; a partir daqui como o meteoro ou nave já chegou à sua forma máxima apenas temos que apagá-lo e desenhá-lo na sua nova
									  ; linha sem alterar a sua forma
continua_apaga_min:
	SUB R1, 1						  ; vai à linha anterior apagar o meteoro
	MOV  [fase_meteoro], R7			  ; escreve a nova forma do meteoro
	MOV  R7, 1						  
	MOV  [sub_met], R7				  ; escreve o valor da altura do meteoro nessa fase
	MOV  R4, DEF_METEORO_MIN		  ; atualizamos a fase do meteoro
	POP  R7
	JMP  continua_apaga
continua_apaga2:
	SUB R1, 2						  ; vai à linha anterior apagar o meteoro
	MOV  [fase_meteoro], R7			  ; escreve a nova forma do meteoro
	MOV  R7, 2
	MOV  [sub_met], R7 				  ; escreve o valor da altura do meteoro nessa fase
	MOV  R4, DEF_METEORO_2            ; atualizamos a fase do meteoro
	POP  R7
	JMP  continua_apaga
continua_apaga3:
	SUB R1, 3						  ; vai à linha anterior apagar o meteoro
	POP  R9				
	MOV  [fase_meteoro], R7			  ; escreve a nova forma da nave
	MOV  R7, 3
	MOV  [sub_met], R7                ; escreve o valor da altura da nave nessa fase
	MOV  R4, DEF_NAVE_3               ; atualizamos a fase do nave
	POP  R7
	JMP  continua_apaga
continua_apaga4:
	SUB R1, 4						  ; vai à linha anterior apagar o meteoro
	POP  R9
	MOV  [fase_meteoro], R7			  ; escreve a nova forma da nave
	MOV  R7, 4
	MOV  [sub_met], R7                ; escreve o valor da altura da nave nessa fase
	MOV  R4, DEF_NAVE_4               ; atualizamos a fase do nave
	POP  R7
	JMP  continua_apaga
continua_apaga_max:
	SUB R1, 5						  ; vai à linha anterior apagar o meteoro
	MOV  [fase_meteoro], R7           ; escreve a nova forma da nave
	MOV  R7, 5
	MOV  [sub_met], R7                ; escreve o valor da altura da nave nessa fase
	MOV  R4, DEF_NAVE_MAX             ; atualizamos a fase do nave
	POP  R7
continua_apaga:
	MOV	 R5, [R4]		      		  ; obtém a largura do meteoro
	ADD  R4, 2				  		  ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]            		  ; obtém a altura do meteoro
	ADD	 R4, 2			      		  ; endereço da cor do 1º pixel (2 porque a largura é uma word)


apaga_pixels_meteoro:         		  ; desenha os pixels do meteoro a partir da tabela
	MOV	 R3, 0				  		  ; cor para apagar o próximo pixel do meteoro
	CALL escreve_pixel		  		  ; escreve cada pixel do meteoro
	ADD	 R4, 2				  		  ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                		  ; próxima coluna
    SUB  R5, 1				  		  ; menos uma coluna para tratar
    JNZ  apaga_pixels_meteoro 		  ; continua até percorrer toda a largura do meteoro
	ADD  R1, 1				  		  ; proxima linha
    MOV  R2, [coluna_atual_meteoro]	  ; repor o valor da coluna inicial
    MOV  R5, LARGURA_MET              ; repor a largura do meteoro para a proxima coluna
	SUB  R10, 1				          ; menos uma linha para tratar
    JNZ  apaga_pixels_meteoro         ; continua até percorrer toda a altura do meteoro
	POP  R10
	POP  R8
	POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
	POP  R1
	RET


apaga_ultima_linha:					  ; apagar a última linha do ecrã (zona correspondente ao meteoro)
	MOV  R2, COLUNA_MEIO_MET		  ; valor da coluna do centro do meteoro
	MOV  R3, 0						  ; cor para apagar o pixel do meteoro
	CALL escreve_pixel_met			  ; escrever o pixel do meteoro
	RET 

; **********************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; **********************************************************************

escreve_pixel_met:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	CALL verifica_colisao
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET

escreve_pixel_missil:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	CALL verifica_colisao_missil
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET


escreve_pixel:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET

; **********************************************************************
; ATRASO - Executa um ciclo para implementar um atraso.
; Argumentos:   R11 - valor que define o atraso
;
; **********************************************************************

atraso:							; implementa um atraso no movimento do rover
	PUSH R11
	MOV R11, 0					

ciclo_atraso:					; quando R11 for zero acaba o atraso
	SUB	 R11, 1
	JNZ	 ciclo_atraso
	POP	 R11
	RET

; **********************************************************************
; TESTA_LIMITES - Testa se o objeto chegou aos limites do ecrã e nesse caso
;			      impede o movimento (força R7 a 0)
; Argumentos: R2 - coluna em que o objeto está
;		   	  R6 - largura do objeto
;			  R7 - sentido de movimento do objeto (valor a somar à coluna
;				em cada movimento: +1 para a direita, -1 para a esquerda)
;
; Retorna: 	  R7 - 0 se já tiver chegado ao limite, inalterado caso contrário	
; **********************************************************************

testa_limites:
	PUSH	R5
	PUSH	R6

testa_limite_esquerdo:		; vê se o objeto chegou ao limite esquerdo
	MOV	R5, MIN_COLUNA		
	CMP	R2, R5				; verifica se a coluna atual é a coluna mais à esquerda
	JGT	testa_limite_direito; se não for a coluna da esquerda, testa a da direita
	CMP	R7, 0			    ; passa a deslocar-se para a direita
	JGE	sai_testa_limites
	JMP	impede_movimento	; entre limites. Mantém o valor do R7
testa_limite_direito:		; vê se o objeto chegou ao limite direito
	ADD	R6, R2			    ; posição a seguir ao extremo direito do objeto
	MOV	R5, MAX_COLUNA
	CMP	R6, R5				; verifica se a coluna atual é a coluna mais à direita
	JLE	sai_testa_limites	; entre limites. Mantém o valor do R7
	CMP	R7, 0			    ; passa a deslocar-se para a direita
	JGT	impede_movimento
	JMP	sai_testa_limites
impede_movimento:
	MOV	R7, 0			    ; impede o movimento, forçando R7 a 0
sai_testa_limites:	
	POP	R6
	POP	R5
	RET

; **********************************************************************
; TECLADO - Faz uma leitura às teclas de uma linha do teclado e retorna o valor lido
; Argumentos: R6 - linha a testar (em formato 1, 2, 4 ou 8)
;
; Retorna:    R0 - valor lido das colunas do teclado (1, 2, 4, ou 8)	
; **********************************************************************

teclado:
	PUSH R2
	PUSH R3
	PUSH R5
	MOV  R2, TEC_LIN   ; endereço do periférico das linhas
	MOV  R3, TEC_COL   ; endereço do periférico das colunas
	MOV  R5, MASCARA   ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
	MOVB [R2], R6      ; escrever no periférico de saída (linhas)
	MOVB R0, [R3]      ; ler do periférico de entrada (colunas)
	AND  R0, R5        ; elimina bits para além dos bits 0-3
	POP	 R5
	POP	 R3
	POP	 R2
	RET



; ******* Conversao dos numeros de hexadecimal para decimal ********
converte_numero:
	PUSH R3				
	PUSH R4
	PUSH R5
	PUSH R7
	MOV R7, DIVISOR				; vou buscar o valor 10
	MOV R3, FATOR			; fator inicializado a 1000
	MOV R5, 0				; resultado começa a 0

ciclo_converte:
	MOD R9, R3				; numero que quero converter MOD fator
	DIV R3, R7				; fator DIV por 10
	MOV R4, R9				; guardo o numero no registo do digito para o poder alterar
	DIV R4, R3				; numero/digito DIV fator
	SHL R5, 4				; desloca para dar espaço ao novo digito
	OR  R5, R4				; compoe o resultado
	CMP R3, R7
	JLT converte_numero_ret
	JMP ciclo_converte

converte_numero_ret:
	MOV R9, R5              ; mover o resultado final para o registo que vamos utilizar fora da funçao
	POP R7
	POP R5
	POP R4
	POP R3
	RET


;**************** Tocar os sons ********************
toca_som0:
	PUSH R9
    MOV  R9, 0                   ; som com número 0
    MOV  [TOCA_SOM], R9          ; comando para tocar o som
    POP  R9
	RET
toca_som1:
	PUSH R9
    MOV  R9, 1                   ; som com número 1
    MOV  [TOCA_SOM], R9          ; comando para tocar o som
    POP  R9
	RET
toca_som2:
	PUSH R9
    MOV  R9, 2                   ; som com número 2
    MOV  [TOCA_SOM], R9          ; comando para tocar o som
    POP  R9
	RET
toca_som3:
	PUSH R9
    MOV  R9, 3                    ; som com número 3
    MOV  [TOCA_SOM], R9           ; comando para tocar o som
	POP R9
	RET

toca_som4:
	PUSH R9
    MOV  R9, 4                    ; som com número 3
    MOV  [TOCA_SOM], R9           ; comando para tocar o som
	POP R9
	RET

toca_som5:
	PUSH R9
    MOV  R9, 5                    ; som com número 3
    MOV  [TOCA_SOM], R9           ; comando para tocar o som
	POP R9
	RET

toca_som6:
	PUSH R9
    MOV  R9, 6                    ; som com número 3
    MOV  [TOCA_SOM], R9           ; comando para tocar o som
	POP R9
	RET

toca_som7:
	PUSH R9
    MOV  R9, 7                    ; som com número 3
    MOV  [TOCA_SOM], R9           ; comando para tocar o som
	POP R9
	RET

termina_som4:
	PUSH R9
    MOV  R9, 4                    ; som com número 3
    MOV  [TERMINA_SOM], R9           ; comando para tocar o som
	POP R9
	RET





; **************** Seleciona cenário para o ecra*************

seleciona_cenario0:
	MOV	 R1, 0							; cenário de fundo número 0
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	RET

seleciona_cenario1:
	MOV	 R1, 1							; cenário de fundo número 1
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	RET

seleciona_cenario2:
	MOV	 R1, 2							; cenário de fundo número 2
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de 
	RET

seleciona_cenario3:
	MOV	 R1, 3							; cenário de fundo número 2
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de 
	RET

seleciona_cenario4:
	MOV	 R1, 4							; cenário de fundo número 2
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de 
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



move_meteoro:
    CALL toca_som0
    ;POP  R0
    PUSH R2
    PUSH R4                            ; repor o valor da linha para desenhar o meteoro
    MOV  R2, [coluna_atual_meteoro]                ; coluna do meteoro
    MOV  R4, DEF_METEORO_MAX            ; endereço da tabela que define o meteoro
    CALL apaga_meteoro                    ; antes de mover temos que apagar o meteoro
	;PUSH R7
	;MOV R7, [sub_met]
    ;SUB  R1, R7
	;POP R7

chegou_a_ultima_linha:                    ; verifica se o limite inferior do meteoro está na ultima linha do ecrã
    PUSH R9
    MOV  R9, ULTIMA_LINHA                ; registo que guarda o valor da última linha
	                            ; adicionamos o tamanho do meteoro que tinhamos tirado
	PUSH R1
	PUSH R7
	;MOV R1, [linha_atual_meteoro]
	;SUB  R1, 5
	INC  R1
    CMP  R1, R9                            ; compara a linha atual do limite inferior do meteoro com a última linha
    JZ   volta_primeira_linha            ; chegou à ultima linha
	MOV R9, [seleciona_meteoro]
	CMP R9, 1
	JNZ ver_nave 
    MOV R9, [colidiu_met]
	CMP R9, 1
	JZ colidiu_meteoro                            ; repomos a linha do meteoro do limite superior
	JMP linha_seguinte
ver_nave:
	MOV R9, [colidiu]
	CMP R9, 1
	JNZ linha_seguinte
	;PUSH R7
	MOV R9, [seleciona_nave]
	MOV R7, [nave_colidida]
	CMP R7, R9
	JNZ linha_seguinte
	;POP R7
	JMP volta_primeira_linha

linha_seguinte:
	POP R7
	POP R1
	POP  R9
    ADD R1, 2                            ; vamos escrever o meteoro uma linha abaixo
    CALL desenha_meteoro

	POP R4
	POP R2
	RET
colidiu_meteoro:
	MOV R9, 0
	MOV [colidiu_met], R9
    
volta_primeira_linha:
	POP R7
	POP R1
	MOV R9, 0
	MOV [colidiu], R9
    POP R9
	;PUSH R1
	MOV R1, 0                            ; vamos escrever o meteoro na primeira linha
	MOV [fase_meteoro], R1
	CALL desenha_meteoro_inicial             	; desenha o meteoro a partir da tabela
	MOV  R2, [coluna_atual_meteoro]                ; coluna do meteoro
	;POP R1
	POP R4
	POP R2
	RET


;;;;;;;;;;;;;;;;;; interrupts ;;;;;;;;;;;;;;;;;;;;;

move_meteoro_interrupt:							; interrupção para mover o meteoro
	PUSH R0
	MOV R0, 1
	MOV [MOV_METEORO], R0						; liga a interrupção
	POP R0
	RFE

dispara_interrupt:								; interrupção para disparar o míssil a partir do rover
	PUSH R0
	MOV R0, 1
	MOV [DISPARA], R0							; liga a interrupção	
	POP R0
	RFE

energia_interrupt:								; interrupção para a energia do rover
	PUSH R0
	MOV R0, 1		
	MOV [ENERGIA], R0							; liga a interrupção
	POP R0
	RFE


;;;;;;;; colisao do meteoro bom com o rover;;;;;;;;;;;;;;;;

verifica_colisao:								; verifica colisão do meteoro bom com o rover
	PUSH R7	
	MOV R7, [COR_ATUAL]							; obtém o valor da cor atual do meteoro
	CMP R7, 0 
	JNZ colide1									; se a cor atual não for transparente continua a verificação
	POP R7
	RET											; se for transparente sai da verificação

colide1:										
	PUSH R9
	MOV R9, COR_METEORO							
	CMP R7, R9 									; compara com a cor do meteoro
	JZ  colide_ret								; se corresponder à cor do meteoro sai da verificação

colide2:										
	PUSH R6	
	MOV R6, COR_MISSIL
	CMP R7, R6 									; compara com a cor do míssil
	JNZ colide3									; se não corresponder à cor do míssil concluimos que colidiu

colide_ret:	
	POP R6
	POP R9
	POP R7
	RET

colide3:
	POP R9
	POP R7
	POP R10
	POP R8
	POP R5
	POP R4
	POP R3
	POP R2
	PUSH R9
	PUSH R7
	MOV R9, 1									
	MOV [colidiu_met], R9						; indica que há uma colisão
	MOV R9, [seleciona_meteoro]					; obtém a indicação se é um meteoro
	CMP R9, 1									
	JNZ vai_terminar_jogo 						; se não for um meteoro, a nave toca no rover logo termina o jogo
	POP R9
	MOV R7, 10
	CALL incrementa								; incrementa a energia do rover a 10
	POP R7
	SUB R1, 4									
	MOV  R2, [coluna_atual_meteoro]             ; obtém a coluna atual do meteoro
	MOV  R1, [linha_atual_meteoro]				; obtém a linha atual do meteoro
    MOV  R4, DEF_METEORO_MAX            		; endereço da tabela que define o meteoro
	ADD  R1, 5									; repõe o valor da linha do meteoro
	CALL apaga_meteoro							; apaga o meteoro pois este colide com o rover
	SUB  R1, 5									; volta à linha do rover
	MOV  R2, [coluna_atual_rover]               ; obtém o valor da coluna do rover
    MOV  R4, DEF_ROVER							; guarda o formato do rover
	CALL desenha_rover							; desenha o rover para o caso do meteoro ter apagado os seus pixeis
	PUSH R7	
	MOV R7, 0									
	MOV [seleciona_meteoro], R7					; repõe o valor da variável que indica se é um meteoro
	POP R7
	JMP loop_meteoro							; volta ao início do processo

vai_terminar_jogo:								; caso em que a nave colide com o rover
	MOV R9, 1									
	MOV [perdeu], R9							; atualiza o valor da variável que indica se perdeu o jogo
	POP R9							
	MOV  [APAGA_TUDO], R1				 		; apaga todos os pixeis do ecrã
	CALL seleciona_cenario4						; seleciona o cenário de explosão do rover
	CALL termina_som4							
	CALL toca_som5								; toca o som de perda do jogo
	JMP loop_meteoro							; volta ao início do processo
	
verifica_colisao_missil:						; verifica se o míssil colide com algo
	PUSH R7	
	MOV R7, [COR_ATUAL]							; obtém a cor atual
	CMP R7, 0 									; verifica se a cor é transparente
	JNZ colide_nave								; se não for transparente é porque colide com a nave ou com o meteoro
	POP R7
	RET


colide_nave:
	PUSH R6
	MOV R6, COR_NAVE1
	CMP R7, R6
	JZ colide_nave1
	MOV R6, COR_NAVE2
	CMP R7, R6
	JZ colide_nave2
	MOV R6, COR_NAVE3
	CMP R7, R6
	JNZ colide_meteoro

colide_nave3:
	MOV R7, 5
	CALL incrementa
	MOV R6, 1
	MOV [colidiu], R6
	MOV R6, 3
	MOV [nave_colidida], R6
	JMP continua_colide

colide_nave2:
	MOV R7, 5
	CALL incrementa
	MOV R6, 1
	MOV [colidiu], R6
	MOV R6, 2
	MOV [nave_colidida], R6
	JMP continua_colide

colide_nave1:	
	MOV R7, 5
	CALL incrementa
	MOV R6, 1
	MOV [colidiu], R6
	MOV R6, 1
	MOV [nave_colidida], R6
	JMP continua_colide

colide_meteoro:
	PUSH R6
	MOV R6, COR_METEORO
	CMP R7, R6
	JNZ continua_colide
	MOV R6, 1
	MOV [colidiu_met], R6

continua_colide:
	POP R6
	POP R7
	MOV  R2, [coluna_atual_meteoro]                ; coluna do meteoro
    MOV  R4, DEF_METEORO_MAX            ; endereço da tabela que define o meteoro
	CALL apaga_meteoro
	MOV R1, [linha_missil]
	MOV R2, [coluna_missil]
	SUB  R1, 3
	SUB  R2, 3                ; coluna do meteoro
	MOV [linha_missil_explosao], R1
	MOV [coluna_missil_explosao], R2
    MOV  R4, DEF_EXPLOSAO

	PUSH R5
	PUSH R6
	MOV R6, 6
	MOV R5, 6

desenha_explosao:
	MOV	 R3, [R4]
	CALL escreve_pixel
	DEC R5
	ADD R4,2
	INC R2               ; colunaaaaaaaaa
	CMP R5, 0
	JNZ desenha_explosao
	DEC R6
	MOV R5, 6
	SUB R2, 6
	INC R1
	CMP R6, 0
	JNZ desenha_explosao
	POP R6
	POP R5
	MOV R7, 1
	MOV [explodiu], R7
	CALL toca_som7
	POP R7
	JMP disparo_ret

apaga_explosao:
	MOV R1, [linha_missil_explosao]
	MOV R2, [coluna_missil_explosao]
	PUSH R5
	PUSH R6
	MOV R6, 6
	MOV R5, 6
apaga_explosao2:
	MOV	 R3, 0
	CALL escreve_pixel
	DEC R5
	INC R2               ; colunaaaaaaaaa
	CMP R5, 0
	JNZ apaga_explosao2
	DEC R6
	MOV R5, 6
	SUB R2, 6
	INC R1
	CMP R6, 0
	JNZ apaga_explosao2
	POP R6
	POP R5
	RET





subtrair_64:
	PUSH R6
	PUSH R7
	MOV R7, 2
	MOV R6, MAX_COLUNA_HEXA
	CMP R9, R6
	JGT subtrair
	POP R7
	POP R6
	RET

subtrair:
	SUB R9, R6
	DIV R9, R7
	INC R7
	CMP R9, R6
	JGT subtrair
	POP R7
	POP R6
	RET

limites_novo_direita1:
	MOV R9, R8														; repoe valor da coluna inicial, gerado aleatoriamente
	INC R5															; passa para a linha abaixo
	MOV R6, 0														; inicializa a 0 o registo que conta o numero de colunas testadas
limites_novo_direita:					
	CMP R5, 7														; vê se chegou à linha 7
	JGT limites_novo_ret											; chegou à linha 7, não queremos testar mais linhas não há perigo de colisão
	INC R6															; incrementa o numero de colunas testadas
	CMP R6, 7                          								; vê se já testou mais de 7 colunas
	JGT limites_novo_direita1										; já testou todas as 7 colunas na linha atual
	INC R9															; passa a testar a coluna à direita
	MOV  [DEFINE_LINHA], R5											; seleciona a linha
	MOV  [DEFINE_COLUNA], R9										; seleciona a coluna
	MOV R7, [COR_ATUAL]												; obtem a cor do pixel na linha e coluna selecionados
	CMP R7, 0														; compara a cor do pixel com 0, ou seja, não há cor
	JZ  limites_novo_direita										; não há um pixel pintado naquela linha e coluna
	MOV R7, 1														
	MOV [vai_colidir], R7											; variavel vai_colidir passa a 1, indicando que se for criado 
																	; um meteoro ou nave naquele sitio vai colidir com outro
	JMP limites_novo_ret											; entao nao precisa de testar mais pixeis

limites_novo_esquerda1:
	MOV R9, R8														; repoe valor da coluna inicial, gerado aleatoriamente
	DEC R5															; passa para a linha de cima
	MOV R6, 7														; numero de colunas a testar em cada linha
limites_novo_esquerda:
	CMP R5, 0														; ve se chegou à primeira linha do ecrã
	JLT limites_novo_ret											; chegou à primeira linha do ecrã, acaba
	DEC R6															; menos uma coluna para testar
	CMP R6, 0														; vê se já testou todas as colunas da linha atual
	JZ limites_novo_esquerda1										; já testou todas as colunas da linha atual
	DEC R9															; passa a testar a coluna da à esquerda
	MOV  [DEFINE_LINHA], R5											; seleciona a linha
	MOV  [DEFINE_COLUNA], R9										; seleciona a coluna
	MOV R7, [COR_ATUAL]												; obtem a cor do pixel na linha e coluna selecionados
	CMP R7, 0														; compara a cor do pixel com 0, ou seja, não há cor
	JZ  limites_novo_esquerda										; não há um pixel pintado naquela linha e coluna
	MOV R7, 1														
	MOV [vai_colidir], R7											; variavel vai_colidir passa a 1, indicando que se for criado 
																	; um meteoro ou nave naquele sitio vai colidir com outro
limites_novo_ret:													; já não há mais pixeis a testar 
	RET

	