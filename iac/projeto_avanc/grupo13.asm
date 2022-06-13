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

LINHA_TECLADO1			EQU 1			; linha a testar (1ª linha)
LINHA_TECLADO2			EQU 2			; linha a testar (2ª linha)
LINHA_TECLADO3			EQU 4			; linha a testar (3ª linha)
LINHA_TECLADO4			EQU 8			; linha a testar (4ª linha)

MASCARA				    EQU 0FH			; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

TECLA_ESQUERDA			EQU 1			; tecla na primeira coluna do teclado (tecla 0)
TECLA_DISPARO			EQU 2			; tecla na segunda coluna do teclado (tecla 1)
TECLA_DIREITA			EQU 4			; tecla na terceira coluna do teclado (tecla 2)
TECLA_METEORO 			EQU 8			; tecla na quarta coluna do teclado (tecla 3)

TECLA_INICIO			EQU 1			; tecla na primeira coluna do teclado (tecla C)
TECLA_SUSPENDE			EQU 2			; tecla na segunda coluna do teclado (tecla D)
TECLA_RETOMA			EQU 2			; tecla na segunda coluna do teclado (tecla D)
TECLA_TERMINA			EQU 4			; tecla na terceira coluna do teclado (tecla E)

DEFINE_LINHA    		EQU 600AH      	; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU 600CH      	; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU 6012H      	; endereço do comando para escrever um pixel

APAGA_TUDO 				EQU 6002H		; endereço do comando para apagar todos os pixeis do ecrã
APAGA_AVISO     		EQU 6040H      	; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRA	 		    EQU 6002H      	; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU 6042H      	; endereço do comando para selecionar uma imagem de fundo
TOCA_SOM				EQU 605AH      	; endereço do comando para tocar um som

PIN                     EQU 0E000H

LINHA_ROVER        		EQU  28        	; linha do rover, quase no fim do ecrã
COLUNA_ROVER			EQU  30        	; coluna do rover, a meio do ecrã
LINHA_MISSIL        	EQU  27        	; linha do missil, quase no fim do ecrã
LINHA_METEORO   		EQU  0			; linha do meteoro, no cimo do ecrã
COLUNA_METEORO  		EQU  15			; coluna do meteoro, à esquerda do ecrã
COLUNA_MEIO_MET			EQU  17			; coluna correspondente ao meio do meteoro
MIN_COLUNA				EQU  0			; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA				EQU  63        	; número da coluna mais à direita que o objeto pode ocupar
MAX_COLUNA_HEXA			EQU  3FH
ATRASO					EQU	 400H		; atraso para limitar a velocidade de movimento do rover
ULTIMA_LINHA			EQU	 32			; ultima linha que o meteoro atinge (fora dos limites do ecrã)

LARGURA_ROVER			EQU	5			; largura do rover
LARGURA_MET		 		EQU 5			; largura do meteoro no seu tamanho máximo
ALTURA_ROVER			EQU	4			; altura do rover
ALTURA_MET_MIN			EQU 1			; altura minima do meteoro
ALTURA_MET_2			EQU 2			; altura do meteoro ao aumentar de tamnho uma vez
ALTURA_MET_3			EQU 3			; altura do meteoro ao aumentar de tamnho duas vezes
ALTURA_MET_4			EQU 4			; altura do meteoro ao aumentar de tamnho três vezes
ALTURA_MET_MAX 			EQU 5			; altura do meteoro no seu tamanho máximo
ALTURA_NAVE_3			EQU 3
ALTURA_NAVE_4			EQU 3
ALTURA_NAVE_MAX			EQU 5
COR_PIXEL_ROVER1	  	EQU	0D58FH		; cor 1 do pixel do rover : azul claro em ARGB 
COR_PIXEL_ROVER2		EQU	0D0EFH		; cor 2 do pixel do rover: ciano em ARGB 
COR_PIXEL_ROVER3		EQU	0D08FH		; cor 3 do pixel do rover: azul escuro em ARGB 
COR_METEORO				EQU 0F0B4H  	; cor do pixel do meteoro: verde em ARGB
COR_METEORO_MIN			EQU 070B4H
COR_METEORO2			EQU 0A0B4H  	; cor do pixel do meteoro: verde em ARGB  	; cor do pixel do meteoro: verde em ARGB
COR_NAVE				EQU 0FF00H
COR_MISSIL				EQU 0FD5DH		; cor do pixel do missil: roxo em ARGB
COR_ATUAL				EQU 6010H

DEZ						EQU 10			
DOZE 					EQU 12
FATOR                   EQU 1000		; fator utilizado para converter numeros hexadecimais e decimais

NUMERO_ECRA 			EQU 6004H
NUMERO_CENARIO			EQU 6046H





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


energia: 			WORD 64H	; variavel que guarda o valor da energia do rover

energia_inicial: 	WORD 64H	; variavel que guarda o valor da energia inicial do rover

coluna_missil:		WORD 32		; variavel que guarda o valor da coluna onde o missil foi disparado

coluna_missil_aux:	WORD 32		; variavel auxiliar que guarda o valor da coluna onde o rover ficou no fim de cada movimento

linha_missil:		WORD 27		; variavel que guarda o valor da linha onde o missil está

coluna_atual_meteoro: WORD 0

coluna_atual_rover: WORD 0

colidiu:    		WORD 0

explodiu:    		WORD 0

linha_missil_explosao: WORD 0

coluna_missil_explosao: WORD 0

fase_meteoro: 			WORD 0

largura_met:			WORD 0

altura_met:				WORD 0

sub_met:				WORD 0

numero_ecra:			WORD 1





; tabela das rotinas de interrupção
BTE_START:
	WORD move_meteoro_interrupt 	; rotina de atendimento da interrupção 0
	WORD dispara_interrupt			; rotina de atendimento da interrupção 1
	WORD energia_interrupt    		; rotina de atendimento da interrupção 2		
	WORD 0


MOV_METEORO: WORD 0					; se 1, indica que a interrupção 0 ocorreu
DISPARA: WORD 0						; se 1, indica que a interrupção 1 ocorreu
ENERGIA: WORD 0						; se 1, indica que a interrupção 1 ocorreu


DEF_ROVER:				; tabela que define o rover (cor, largura, pixels)
	WORD		LARGURA_ROVER
	WORD		ALTURA_ROVER
	WORD		0, 0, COR_PIXEL_ROVER2, 0, 0
	WORD		COR_PIXEL_ROVER3, 0, COR_PIXEL_ROVER1, 0, COR_PIXEL_ROVER3
	WORD		COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1
	WORD        COR_PIXEL_ROVER1, 0, 0, 0, COR_PIXEL_ROVER1	

DEF_METEORO_MIN:		; tabela que define o meteoro inicial (cor, largura, pixels)
	WORD		LARGURA_MET
	WORD		ALTURA_MET_MIN
	WORD		0, 0, COR_METEORO_MIN, 0, 0

DEF_METEORO_2:		; tabela que define o meteoro quando aumenta de tamanho uma vez (cor, largura, pixels)
	WORD		LARGURA_MET
	WORD		ALTURA_MET_2
	WORD		0, COR_METEORO2, COR_METEORO2, 0, 0
	WORD		0, COR_METEORO2, COR_METEORO2, 0, 0

DEF_METEORO_3:		; tabela que define o meteoro quando aumenta de tamanho duas vezes (cor, largura, pixels)
	WORD		LARGURA_MET
	WORD		ALTURA_MET_3
	WORD		0, 0, COR_METEORO, 0, 0
	WORD 		0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD		0, 0, COR_METEORO, 0, 0

DEF_METEORO_4:		; tabela que define o meteoro quando aumenta de tamanho 3 vezes (cor, largura, pixels)
	WORD		LARGURA_MET
	WORD		ALTURA_MET_4
	WORD		0, COR_METEORO, COR_METEORO, 0, 0
	WORD 		COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD 		COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD		0, COR_METEORO, COR_METEORO, 0, 0

DEF_METEORO_MAX:		; tabela que define o meteoro no seu tamanho maximo (cor, largura, pixels)
	WORD		LARGURA_MET
	WORD		ALTURA_MET_MAX
	WORD		0, 0, COR_METEORO, 0, 0
	WORD 		0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD 		COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO
	WORD 		0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD		0, 0, COR_METEORO, 0, 0

DEF_NAVE_3:
	WORD		LARGURA_MET
	WORD		ALTURA_NAVE_3
	WORD		0, COR_NAVE, 0, COR_NAVE, 0
	WORD 		0, 0, COR_NAVE, 0, 0
	WORD		0, COR_NAVE, 0, COR_NAVE, 0

DEF_NAVE_4:
	WORD		LARGURA_MET
	WORD		ALTURA_NAVE_4
	WORD		COR_NAVE, 0, COR_NAVE, 0, COR_NAVE
	WORD 		0, COR_NAVE, COR_NAVE, COR_NAVE, 0
	WORD		0, COR_NAVE, 0, COR_NAVE, 0

DEF_NAVE_MAX:
	WORD		LARGURA_MET
	WORD		ALTURA_NAVE_MAX
	WORD		COR_NAVE, 0, COR_NAVE, 0, COR_NAVE
	WORD 		COR_NAVE, 0, COR_NAVE, 0, COR_NAVE
	WORD		0, COR_NAVE, COR_NAVE, COR_NAVE, 0
	WORD		0, COR_NAVE, 0, COR_NAVE, 0
	WORD		0, 0, COR_NAVE, 0, 0

DEF_EXPLOSAO:		; tabela que define o meteoro no seu tamanho maximo (cor, largura, pixels)

	WORD		COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD 		0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL
	WORD 		COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD 		0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL
	WORD		COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL, 0
	WORD		0,COR_MISSIL, 0, COR_MISSIL, 0, COR_MISSIL


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


espera_tecla_inicio:					; neste ciclo espera-se até a tecla de iniciar o jogo ser premida
	MOV  R6, LINHA_TECLADO4				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, TECLA_INICIO
	JNZ espera_tecla_inicio				; repete o ciclo se não for a tecla C
	
comeca_jogo:							; foi premida a tecla de inicio e o jogo começa
	CALL toca_som2						; toca o som de inicio de jogo
	CALL seleciona_cenario0				; seleciona o cenário do jogo
	MOV	 R7, 1							; valor a somar à coluna do objeto, para o movimentar
	MOV  R9, [energia_inicial] 			; guarda o valor da energia inicial
	MOV  [energia], R9					; iniciar a energia a 100
 	MOV  R11, DISPLAYS  				; endereço do periférico dos displays
    CALL converte_numero				; converte o valor da energia de hexadecimal para decimal
	MOV  [R11], R9      				; escreve a energia do rover nos displays

posicao_rover:
    MOV  R2, COLUNA_ROVER				; coluna do rover
	MOV  [coluna_atual_rover], R2
	MOV	 R4, DEF_ROVER					; endereço da tabela que define o rover
	CALL desenha_rover


posicao_meteoro:						; definir a posição inicial do meteoro
    MOV  R1, LINHA_METEORO				; linha do meteoro
	MOV	 R4, DEF_METEORO_MAX			; endereço da tabela que define o meteoro
	PUSH R7
	MOV  R7, 1
	MOV  [NUMERO_CENARIO], R7
	CALL desenha_meteoro_inicial
	MOV  R7, 2
	MOV  [NUMERO_CENARIO], R7
	CALL desenha_meteoro_inicial
	MOV  R7, 3
	MOV  [NUMERO_CENARIO], R7
	CALL desenha_meteoro_inicial
	MOV  R7, 4
	MOV  [NUMERO_CENARIO], R7
	CALL desenha_meteoro_inicial
	POP  R7

inicio_processos: 			; permite as interrupções e inicia os processos
	EI0						; permite interrupções 0
	EI1 					; permite interrupções 1
	EI2 					; permite interrupções 1
	EI						; permite interrupções (geral)

	CALL loop_meteoro   	; inicia o processo que move o meteoro
	CALL disparo			; inicia o processo que dispara o missil
	CALL rover				; inicia o processo que move o rover
	CALL energia_decrementa

programa_principal:
	YIELD
	
	espera_tecla2:							; neste ciclo espera-se até uma tecla da linha 2 ser premida
		YIELD
		MOV R6, LINHA_TECLADO2				; linha a testar no teclado
		CALL teclado						; leitura às teclas
		CMP	 R0, 0						
		JZ   espera_tecla3					; espera, enquanto não houver tecla


	;;;;;;;;;;;;;;;;;;;;	LINHA 3		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	espera_tecla3:							; neste ciclo espera-se até uma tecla da linha 3 ser premida
		YIELD
		MOV R6, LINHA_TECLADO3				; linha a testar no teclado
		CALL teclado						; leitura às teclas
		CMP	 R0, 0							; este registo indica se existe tecla premida
		JZ   espera_tecla4					; espera, enquanto não houver tecla

	;;;;;;;;;;;;;;;;;;;;	LINHA 4		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	espera_tecla4:							; neste ciclo espera-se até uma tecla ser premida
		YIELD
		MOV R6, LINHA_TECLADO4				; linha a testar no teclado
		CALL teclado						; leitura às teclas
		CMP	 R0, 0
		JZ programa_principal				; nao houve uma tecla premida, volta ao inicio do programa principal
	
	suspende_jogo:							; verifica se a tecla premida é a de suspender o jogo (tecla D)
		CMP R0, TECLA_SUSPENDE
		JZ	espera_nao_tecla4				; pára o jogo
		

	termina_jogo:							; verifica se a tecla premida é a de terminar o jogo (tecla E)
		CMP R0, TECLA_TERMINA
		JZ	apaga_tudo						; o jogo terminou, vai apagar tudo
		JMP espera_tecla2					; o jogo nao terminou


	espera_nao_tecla4:						; neste ciclo espera-se até não estar premida alguma tecla da linha 4
		CALL seleciona_cenario3
		CALL teclado						; leitura às teclas
		CMP R0, 0							
		JZ disable							; como não há nenhuma tecla, suspende-se o jogo
		JMP espera_nao_tecla4

	apaga_tudo:
		MOV  [APAGA_TUDO], R1				; apaga todos os pixeis do ecrã
		CALL seleciona_cenario2

	fim:									; o jogo terminou
		DI
		JMP espera_tecla_inicio				; vamos esperar que seja premida a tecla que inicia o jogo

	disable:								; desliga as interrupções
		DI
	
	jogo_suspenso:							; espera até tecla premida é a de continua o jogo (tecla D)
		CALL teclado						; leitura às teclas
		CMP R0, TECLA_RETOMA				; verifica se a tecla premida é a tecla de retomar om jogo
		JNZ	jogo_suspenso					; enquanto nao for, o jogo continua suspenso				
	
	retoma_enable:							; volta a ligar as interrupções
		CALL seleciona_cenario1
		EI
	
	espera_nao_tecla_suspensa:				; neste ciclo espera-se até não estar premida a tecla de retomar o jogo
		CALL teclado
		CMP R0, 0
		JZ espera_tecla2					; como a tecla não está premida, retoma-se o jogo
		JMP espera_nao_tecla_suspensa		; enquanto a tecla estiver premida o jogo nao avança

		
	JMP programa_principal					; volta ao inicio do programa principal


decrementa:								; decrementa valor do display
	PUSH R9							    
	MOV R9, [energia]					; guarda o valor atual da energia num registo
	SUB R9, 5								
	MOV [energia], R9					; altera o valor da energia depois da decrementação
	CALL converte_numero
	MOV [R11], R9						; escreve o valor no display
	CMP R9,0
	JNZ nao_perde						; a energia do rover chegou a zero
	CALL perde_jogo
	RET

nao_perde:
	POP R9								
	RET				

perde_jogo:
	POP R9
	CALL toca_som1
	JMP apaga_tudo						; vai apagar o ecrã
	RET

incrementa:
	PUSH R3								; incrementa valor do display
	PUSH R9
	MOV R3, [energia_inicial]			; guarda o valor inicial que é o maximo da energia			
	MOV R9, [energia]					; guarda o valor atual da energia num registo
	ADD R9, R7
	CMP R9, R3							; verifica se a energia for aumentada, ultrapassa a energia máxima
	JGT nao_incrementa
	MOV R3, ULTIMA_LINHA
	CMP R1, R3
	JZ  nao_incrementa
	CALL toca_som3
	MOV [energia], R9					; altera o valor da energia depois da incrementação
	CALL converte_numero				
	MOV [R11], R9						; escreve o valor no display

nao_incrementa:							; nao incrementa a energia, se incrementasse ultrapassaria a energia máxima
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
	MOV  R1, LINHA_ROVER	  ; o valor anterior de R1 é a linha do meteoro
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	MOV	 R5, [R4]		      ; obtém a largura do rover
	ADD  R4, 2				  ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]            ; obtém a altura do rover
	ADD	 R4, 2			      ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2				  ; guarda a coluna atual
	MOV  [coluna_atual_rover], R2     ; o valor anteior de R2 é a coluna do Rover

desenha_pixels_rover:      	  ; desenha os pixels do rover a partir da tabela
	MOV	 R3, [R4]			  ; obtém a cor do próximo pixel do rover
	CALL escreve_pixel		  ; escreve cada pixel do rover
	ADD	 R4, 2			      ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                ; próxima coluna
	SUB  R5, 1 		          ; menos uma coluna para tratar
	JNZ  desenha_pixels_rover ; continua até percorrer toda a largura do rover
	ADD  R1, 1				  ; proxima linha
    MOV  R2, [coluna_atual_rover]				  ; repor o valor da coluna inicial
	MOV  R2, R8
    MOV  R5, LARGURA_ROVER	  ; repor a largura do rover para a proxima coluna
	SUB  R10, 1				  ; menos uma linha para tratar
    JNZ  desenha_pixels_rover ; continua até percorrer toda a altura do objeto
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
	MOV  R1, LINHA_ROVER	; o valor anterior de R1 é a linha do meteoro
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	MOV	 R5, [R4]		    ; obtém a largura do rover
	ADD  R4, 2				; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]          ; obtém a altura do rover
	ADD	 R4, 2			    ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2				; guarda a coluna atual
	;MOV  [coluna_atual_rover], R2   ; o valor anteior de R2 é a coluna do Rover

apaga_pixels_rover:         ; desenha os pixels do rover a partir da tabela
	MOV	 R3, 0				; cor para apagar o próximo pixel do rover
	CALL escreve_pixel		; escreve cada pixel do rover
	ADD	 R4, 2				; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1              ; próxima coluna
    SUB  R5, 1				; menos uma coluna para tratar
    JNZ  apaga_pixels_rover ; continua até percorrer toda a largura do objeto
	ADD  R1, 1				; proxima linha
    MOV  R2, R8				; repor o valor da coluna inicial
    ;MOV  R2, [coluna_atual_rover]   ; o valor anteior de R2 é a coluna do Rover
	MOV  R5, LARGURA_ROVER	; repor a largura do rover para a proxima coluna
	SUB  R10, 1				; menos uma linha para tratar
    JNZ  apaga_pixels_rover ; continua até percorrer toda a altura do rover
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
;	PUSH R7
;	MOV R7, [explodiu]
;	CMP R7, 1
;	JNZ desenha_meteoro_inicial2
;	POP R7
;	CALL apaga_explosao
;desenha_meteoro_inicial2:
	;POP R7
	PUSH R2
	;MOV  R2, COLUNA_METEORO     ; o valor anteior de R2 é a coluna do Rover
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	PUSH R9
	PUSH R1
	PUSH R7
	MOV  R7, 1
	MOV  [NUMERO_CENARIO], R7
	MOV  R7, 1
	MOV  [sub_met], R7
	POP  R7
	MOV R1, 1
	MOV [fase_meteoro], R1
	POP R1
	MOV R4, DEF_METEORO_MIN

gera_aleatoriamente:
	MOV R9, [PIN]
	SHR R9, 5
	CALL subtrair_64
	MOV  R5, [R4]                ; obtém a largura do meteoro
	ADD  R4, 2                    ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]              ; obtém a altura do meteoro
	ADD  R4, 2                    ; endereço da cor do 1º pixel (2 porque a largura é uma word)
	;MOV  R8, R9                ; guardar o valor da coluna atual
	MOV [coluna_atual_meteoro], R9
	MOV R2, R9
	POP R9
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
	MOV  R7, 1
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_MIN
	JMP  continua_desenha					; guardar o valor da coluna atual
continua_desenha2:
	MOV  R7, 2
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_2
	JMP  continua_desenha					; guardar o valor da coluna atual
continua_desenha3:
	POP  R9
	MOV  R7, 3
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_3
	JMP  continua_desenha					; guardar o valor da coluna atual
continua_desenha4:
	POP  R9
	MOV  R7, 4
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_4
	JMP  continua_desenha					; guardar o valor da coluna atual		
continua_desenha_max:
	MOV  R7, 5
	MOV  [sub_met], R7
	POP  R7
	MOV  R4, DEF_METEORO_MAX
continua_desenha:
	MOV	 R5, [R4]		        ; obtém a largura do meteoro
	ADD  R4, 2				    ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]              ; obtém a altura do meteoro
	ADD	 R4, 2			        ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    ;MOV  R8, R2					; guardar o valor da coluna atual
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
	MOV  R2, [coluna_atual_meteoro]   ; o valor anteior de R2 é a coluna do Rover
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	PUSH R7
	MOV  R7, [fase_meteoro]
	INC  R7
	CMP  R7, 3
	JLT  continua_apaga_min
	CMP  R7, 6
	JLT  continua_apaga2
	PUSH R9
	MOV  R9, 9
	CMP  R7, R9
	JLT  continua_apaga3
	MOV  R9, 12
	CMP  R7, R9
	JLT  continua_apaga4
	POP  R9
	JMP  continua_apaga_max
continua_apaga_min:
	MOV  [fase_meteoro], R7
	MOV  R7, 1
	MOV  [sub_met], R7
	MOV  R4, DEF_METEORO_MIN
	POP  R7
	JMP  continua_apaga
continua_apaga2:
	MOV  [fase_meteoro], R7
	MOV  R7, 2
	MOV  [sub_met], R7
	MOV  R4, DEF_METEORO_2
	POP  R7
	JMP  continua_apaga
continua_apaga3:
	POP  R9
	MOV  [fase_meteoro], R7
	MOV  R7, 3
	MOV  [sub_met], R7
	MOV  R4, DEF_METEORO_3
	POP  R7
	JMP  continua_apaga
continua_apaga4:
	POP  R9
	MOV  [fase_meteoro], R7
	MOV  R7, 4
	MOV  [sub_met], R7
	MOV  R4, DEF_METEORO_4
	POP  R7
	JMP  continua_apaga
continua_apaga_max:
	MOV  [fase_meteoro], R7
	MOV  R7, 5
	MOV  [sub_met], R7
	MOV  R4, DEF_METEORO_MAX
	POP  R7
continua_apaga:
	MOV	 R5, [R4]		      ; obtém a largura do meteoro
	ADD  R4, 2				  ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]            ; obtém a altura do meteoro
	ADD	 R4, 2			      ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    ;MOV  R8, R2				  ; guardar o valor da linha atual


apaga_pixels_meteoro:         ; desenha os pixels do meteoro a partir da tabela
	MOV	 R3, 0				  ; cor para apagar o próximo pixel do meteoro
	CALL escreve_pixel		  ; escreve cada pixel do meteoro
	ADD	 R4, 2				  ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                ; próxima coluna
    SUB  R5, 1				  ; menos uma coluna para tratar
    JNZ  apaga_pixels_meteoro ; continua até percorrer toda a largura do meteoro
	ADD  R1, 1				  ; proxima linha
    MOV  R2, [coluna_atual_meteoro]				  ; repor o valor da coluna inicial
    MOV  R5, LARGURA_MET  ; repor a largura do meteoro para a proxima coluna
	SUB  R10, 1				  ; menos uma linha para tratar
    JNZ  apaga_pixels_meteoro ; continua até percorrer toda a altura do meteoro
	POP  R10
	POP  R8
	POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
	POP  R1
	RET


apaga_ultima_linha:				; apagar a última linha do ecrã (zona correspondente ao meteoro)
	MOV  R2, COLUNA_MEIO_MET	; valor da coluna do centro do meteoro
	MOV  R3, 0					; cor para apagar o pixel do meteoro
	CALL escreve_pixel_met			; escrever o pixel do meteoro
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
	MOV R7, DEZ				; vou buscar o valor 10
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PROCESS SP_inicial_rover

rover:							; neste ciclo espera-se até uma tecla ser premida
	YIELD
	MOV  R6, LINHA_TECLADO1				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0
	JZ rover

ha_tecla:								; vê se é para deslocar o rover para a esquerda ou direita
	;POP  R0
	CALL atraso							; atraso para limitar a velocidade do rover
	CMP	 R0, TECLA_ESQUERDA				
	JNZ	 testa_direita					; se não for a tecla da esquerda vê se é a da direita
	MOV	 R7, -1							; vai deslocar para a esquerda
	JMP	 ve_limites						; vai verificar se o objeto está ou não nos limites do ecrã

testa_direita:
	CMP	 R0, TECLA_DIREITA
	JNZ	 rover					; caso em que não move o rover
	MOV	 R7, +1							; vai deslocar para a direita
	
ve_limites:								; verifica se o objeto está ou não nos limites do ecrã
	MOV	 R6, [R4]						; obtém a largura do rover
	CALL testa_limites					; vê se chegou aos limites do ecrã e se sim força R7 a 0
	CMP	 R7, 0							
	JZ	 rover					; se não é para movimentar o objeto, vai ler o teclado de novo

move_rover:								; para deslocar o rover apagamos primeiro
	PUSH R1
	CALL apaga_rover					; apaga o rover na sua posição corrente
	
coluna_seguinte:						
	ADD	R2, R7							; para desenhar o rover na coluna seguinte (direita ou esquerda)

	ADD R2, 2
	MOV [coluna_missil_aux], R2
	SUB R2, 2
	JMP	mostra_rover					; vai desenhar o rover de novo
	POP R1

mostra_rover:
	MOV	 R4, DEF_ROVER
	CALL desenha_rover					; desenha o rover a partir da tabela
	JMP rover


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PROCESS SP_inicial_meteoro

loop_meteoro:
	YIELD	

	MOV R0, [MOV_METEORO]
	CMP R0, 0
	JZ loop_meteoro

	MOV R0, 0
	MOV [MOV_METEORO], R0

	CALL move_meteoro
	JMP loop_meteoro

move_meteoro:
    CALL toca_som0
    ;POP  R0
    PUSH R2
    PUSH R4
	PUSH R7
	MOV R7, [sub_met]
    SUB  R1, R7
	POP R7                            ; repor o valor da linha para desenhar o meteoro
    MOV  R2, [coluna_atual_meteoro]                ; coluna do meteoro
    MOV  R4, DEF_METEORO_MAX            ; endereço da tabela que define o meteoro
    CALL apaga_meteoro                    ; antes de mover temos que apagar o meteoro

chegou_a_ultima_linha:                    ; verifica se o limite inferior do meteoro está na ultima linha do ecrã
    PUSH R9
    MOV  R9, ULTIMA_LINHA                ; registo que guarda o valor da última linha
    ;ADD  R1, 5                            ; adicionamos o tamanho do meteoro que tinhamos tirado
    CMP  R1, R9                            ; compara a linha atual do limite inferior do meteoro com a última linha
    JZ   volta_primeira_linha            ; chegou à ultima linha
    MOV R9, [colidiu]
	CMP R9, 1
	JZ volta_primeira_linha
	POP  R9
    ;SUB  R1, 5                            ; repomos a linha do meteoro do limite superior

linha_seguinte:
    ADD R1, 2                            ; vamos escrever o meteoro uma linha abaixo
    CALL desenha_meteoro
	POP R4
	POP R2
	RET

volta_primeira_linha:
    POP R9
	PUSH R9
	MOV R9, 0
	MOV [colidiu], R9
    POP R9
	MOV R1, 0                            ; vamos escrever o meteoro na primeira linha
	CALL desenha_meteoro_inicial             	; desenha o meteoro a partir da tabela
	POP R4
	POP R2
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PROCESS SP_inicial_disparo

disparo:								; verifica se a tecla premida é a do disparo (tecla 1)
	YIELD

	MOV R6, LINHA_TECLADO1				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0
	JZ 	disparo


disparo2:
	CMP R0, TECLA_DISPARO	
	JNZ disparo_ret
	CALL decrementa
	PUSH R7
	MOV R7, LINHA_MISSIL
	MOV [linha_missil], R7	
	MOV R7, [coluna_missil_aux]
	MOV [coluna_missil], R7
	POP R7	
	CALL desenha_missil
	MOV R9, 0
	MOV R7, DOZE
	JMP loop_missil					; vai para rover pois não é suposto realizar esta funcionalidade

disparo_ret:
	JMP disparo

desenha_missil:
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R1, [linha_missil]
	MOV R2, [coluna_missil]
	MOV R3, COR_MISSIL
	CALL escreve_pixel_missil
	POP R3
	POP R2
	POP R1
	RET

move_missil:
    CALL toca_som0
    ;POP  R0
	PUSH R1
    PUSH R2
	PUSH R7
    MOV  R1, [linha_missil]
	MOV  R2, [coluna_missil]                ; coluna do meteoro
    ;MOV  R4, DEF_METEORO_MAX            ; endereço da tabela que define o meteoro
    CALL apaga_missil                    ; antes de mover temos que apagar o meteoro
	MOV R7, [linha_missil]
	DEC R7
	MOV [linha_missil], R7
	CALL desenha_missil
	POP R7
	POP R2
	POP R1
	RET

apaga_missil:
	PUSH R3
	MOV R3, 0
	CALL escreve_pixel
	POP R3
	RET

loop_missil:
	YIELD
	MOV R0, [DISPARA]
	CMP R0, 0
	JZ loop_missil

	MOV R0, 0
	MOV [DISPARA], R0

	CALL move_missil
	INC R9
	CMP R9, R7
	JNZ loop_missil
	PUSH R1
	PUSH R2
	MOV  R1, [linha_missil]
	MOV  R2, [coluna_missil]                ; coluna do meteoro
	CALL apaga_missil
	POP R2
	POP R1
	JMP disparo_ret



PROCESS SP_inicial_energia

energia_decrementa:
	YIELD

	MOV R0, [ENERGIA]
	CMP R0, 0
	JZ energia_decrementa

	MOV R0, 0
	MOV [ENERGIA], R0


	CALL decrementa
	JMP energia_decrementa

;;;;;;;;;;;;;;;;;; interrupts ;;;;;;;;;;;;;;;;;;;;;

move_meteoro_interrupt:
	PUSH R0

	MOV R0, 1
	MOV [MOV_METEORO], R0

	POP R0
	RFE

dispara_interrupt:
	PUSH R0

	MOV R0, 1
	MOV [DISPARA], R0

	POP R0
	RFE

energia_interrupt:
	PUSH R0

	MOV R0, 1
	MOV [ENERGIA], R0

	POP R0
	RFE


;;;;;;;; colisao do meteoro bom com o rover;;;;;;;;;;;;;;;;
verifica_colisao:
	PUSH R7
	MOV R7, [COR_ATUAL]
	CMP R7, 0 
	JNZ colide1
	POP R7
	RET
colide1:
	PUSH R9
	MOV R9, COR_METEORO
	CMP R7, R9 
	JNZ colide2
colide2:
	PUSH R6
	MOV R6, COR_MISSIL
	CMP R7, R6 
	JNZ colide3
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
	MOV R9, 1
	MOV [colidiu], R9
	MOV R9, [NUMERO_ECRA]
	MOV [numero_ecra], R9
	POP R9
	PUSH R7
	MOV R7, 10
	CALL incrementa
	POP R7
	SUB R1, 4
	MOV  R2, [coluna_atual_meteoro]                ; coluna do meteoro
    MOV  R4, DEF_METEORO_MAX            ; endereço da tabela que define o meteoro
	CALL apaga_meteoro
	MOV  R2, [coluna_atual_rover]                ; coluna do meteoro
    MOV  R4, DEF_ROVER
	CALL desenha_rover
	JMP loop_meteoro

verifica_colisao_missil:
	PUSH R7
	MOV R7, [COR_ATUAL]
	CMP R7, 0 
	JNZ colide_missil
	POP R7
	RET

colide_missil:
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
	POP R7
	JMP loop_missil

;apaga_explosao:
;	MOV R1, [linha_missil_explosao]
;	MOV R2, [coluna_missil_explosao]
;	PUSH R5
;	PUSH R6
;	MOV R6, 6
;	MOV R5, 6
;apaga_explosao2:
;	MOV	 R3, 0
;	CALL escreve_pixel
;	DEC R5
;	INC R2               ; colunaaaaaaaaa
;	CMP R5, 0
;	JNZ apaga_explosao2
;	DEC R6
;	MOV R5, 6
;	SUB R2, 6
;	INC R1
;	CMP R6, 0
;	JNZ apaga_explosao2
;	POP R6
;	POP R5
;	RET





subtrair_64:
	PUSH R6
	MOV R6, MAX_COLUNA_HEXA
	CMP R9, R6
	JGT subtrair
	POP R6
	RET

subtrair:
	SUB R9, R6
	CMP R9, R6
	JGT subtrair
	POP R6
	RET