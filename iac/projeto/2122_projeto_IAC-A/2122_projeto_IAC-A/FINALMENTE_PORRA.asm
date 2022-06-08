; *********************************************************************************
; * Identificação: Daniel Nunes ist1103095
; *                João Costa   ist1102078
; *                Luana Ferraz ist1102908
; * IST-UL
; * Modulo:    projeto_int.asm
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
TECLA_TERMINA			EQU 4			; tecla na terceira coluna do teclado (tecla E)

DEFINE_LINHA    		EQU 600AH      	; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU 600CH      	; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU 6012H      	; endereço do comando para escrever um pixel

APAGA_AVISO     		EQU 6040H      	; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRA	 		    EQU 6002H      	; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU 6042H      	; endereço do comando para selecionar uma imagem de fundo
TOCA_SOM				EQU 605AH      	; endereço do comando para tocar um som

LINHA_ROVER        		EQU  28        	; linha do rover, quase no fim do ecrã
COLUNA_ROVER			EQU  30        	; coluna do rover, a meio do ecrã
LINHA_METEORO   		EQU  0			; linha do meteoro, no cimo do ecrã
COLUNA_METEORO  		EQU  15			; coluna do meteoro, à esquerda do ecrã
COLUNA_MEIO_MET			EQU  17			; coluna correspondente ao meio do meteoro
MIN_COLUNA				EQU  0			; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA				EQU  63        	; número da coluna mais à direita que o objeto pode ocupar
ATRASO					EQU	 400H		; atraso para limitar a velocidade de movimento do rover
ULTIMA_LINHA			EQU	 36			; ultima linha que o meteoro atinge (fora dos limites do ecrã)

LARGURA_ROVER			EQU	5			; largura do rover
ALTURA_ROVER			EQU	4			; altura do rover
LARGURA_MET_MAX 		EQU 5			; largura do meteoro
ALTURA_MET_MAX 			EQU 5			; altura do meteoro
COR_PIXEL_ROVER1	  	EQU	0D58FH		; cor 1 do pixel do rover : azul claro em ARGB 
COR_PIXEL_ROVER2		EQU	0D0EFH		; cor 2 do pixel do rover: ciano em ARGB 
COR_PIXEL_ROVER3		EQU	0D08FH		; cor 3 do pixel do rover: azul escuro em ARGB 
COR_METEORO				EQU 0A0B4H  	; cor do pixel do meteoro: verde em ARGB



; *********************************************************************************
; * Dados 
; *********************************************************************************
	
	PLACE 1000H
pilha:
	STACK 100H			; espaço reservado para a pilha 
SP_inicial:				; este é o endereço com que o SP deve ser 
						; inicializado.
							
DEF_ROVER:				; tabela que define o rover (cor, largura, pixels)
	WORD		LARGURA_ROVER
	WORD		ALTURA_ROVER
	WORD		0, 0, COR_PIXEL_ROVER2, 0, 0
	WORD		COR_PIXEL_ROVER3, 0, COR_PIXEL_ROVER1, 0, COR_PIXEL_ROVER3
	WORD		COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1, COR_PIXEL_ROVER1
	WORD        COR_PIXEL_ROVER1, 0, 0, 0, COR_PIXEL_ROVER1	

DEF_METEORO_MAX:		; tabela que define o meteoro (cor, largura, pixels)
	WORD		LARGURA_MET_MAX
	WORD		ALTURA_MET_MAX
	WORD		0, 0, COR_METEORO, 0, 0
	WORD 		0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD 		COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO, COR_METEORO
	WORD 		0, COR_METEORO, COR_METEORO, COR_METEORO, 0
	WORD		0, 0, COR_METEORO, 0, 0


; *********************************************************************************
; * Código
; *********************************************************************************

PLACE   0                     			; o código tem de começar em 0000H
inicio:
	MOV  SP, SP_inicial					; inicializa SP para a palavra a seguir
						                ; à última da pilha                         
    MOV  [APAGA_AVISO], R1				; apaga o aviso de nenhum cenário selecionado
    MOV  [APAGA_ECRA], R1				; apaga todos os pixels já desenhados 
	MOV	 R1, 0							; cenário de fundo número 0
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	MOV	 R7, 1							; valor a somar à coluna do objeto, para o movimentar
	MOV  R9, 0 
 	MOV  R11, DISPLAYS  				; endereço do periférico dos displays
    MOV  [R11], R9      				; escreve linha e coluna a zero nos displays


posicao_rover:
    MOV  R2, COLUNA_ROVER				; coluna do rover
	MOV	 R4, DEF_ROVER					; endereço da tabela que define o rover

mostra_rover:
	CALL desenha_rover					; desenha o rover a partir da tabela
	CMP R1, 0							; verificar se estamos no início do programa para desenhar o resto
	JNZ ainda_ha_tecla

posicao_meteoro:						; definir a posição inicial do meteoro
	PUSH R2								; valor que será modificado e utilizado no desenho do meteoro
	PUSH R4								; valor para ler a tabela do meteoro
    MOV  R1, LINHA_METEORO				; linha do meteoro
	MOV	 R4, DEF_METEORO_MAX			; endereço da tabela que define o meteoro

mostra_meteoro:
	CALL desenha_meteoro             	; desenha o meteoro a partir da tabela
	POP R4
	POP R2

espera_nao_tecla1:						; neste ciclo espera-se até não haver nenhuma tecla premida na linha 1
	MOV  R6, LINHA_TECLADO1				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0							; este registo indica se existe tecla premida
	JNZ	 espera_nao_tecla1				; espera, enquanto houver tecla uma tecla carregada

ainda_ha_tecla:							; verifica se existe alguma tecla premida
	MOV  R6, LINHA_TECLADO1				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	PUSH R0
	CMP	 R0, 0							; este registo indica se existe tecla premida
	JNZ  ha_tecla						; se houver uma tecla premida executa um movimento

espera_nao_tecla2:						; neste ciclo espera-se até não haver nenhuma tecla premida na linha 2
	MOV  R6, LINHA_TECLADO2				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0							; este registo indica se existe tecla premida
	JNZ	 espera_nao_tecla2				; espera, enquanto houver tecla uma tecla carregada

espera_tecla1:							; neste ciclo espera-se até uma tecla ser premida
	MOV  R6, LINHA_TECLADO1				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0
	JZ   espera_tecla2					; espera, enquanto não houver tecla

;;;;;;;;;;;;;;;;;;;;	LINHA 1		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

disparo:								; verifica se a tecla premida é a do disparo (tecla 1)
	CMP R0, TECLA_DISPARO				
	JZ	espera_tecla1					; vai para espera_tecla1 pois não é suposto realizar esta funcionalidade


tecla_move_meteoro:						; verifica se a tecla premida é a do meteoro (tecla 3)
	PUSH R0
	DEC  R0								; decrementação de R0 para se puder usar o CMP
	CMP  R0, TECLA_METEORO-1			; verificar se a tecla premida é a que movimenta o meteoro
	JZ   move_meteoro					; vai movimentar o meteoro

ha_tecla:								; vê se é para deslocar o rover para a esquerda ou direita
	POP  R0
	CALL atraso							; atraso para limitar a velocidade do rover
	CMP	 R0, TECLA_ESQUERDA				
	JNZ	 testa_direita					; se não for a tecla da esquerda vê se é a da direita
	MOV	 R7, -1							; vai deslocar para a esquerda
	JMP	 ve_limites						; vai verificar se o objeto está ou não nos limites do ecrã
testa_direita:
	CMP	 R0, TECLA_DIREITA
	JNZ	 espera_tecla1					; caso em que não move o rover
	MOV	 R7, +1							; vai deslocar para a direita
	
ve_limites:								; verifica se o objeto está ou não nos limites do ecrã
	MOV	 R6, [R4]						; obtém a largura do rover
	CALL testa_limites					; vê se chegou aos limites do ecrã e se sim força R7 a 0
	CMP	 R7, 0							
	JZ	 espera_tecla1					; se não é para movimentar o objeto, vai ler o teclado de novo

move_rover:								; para deslocar o rover apagamos primeiro
	PUSH R1
	CALL apaga_rover					; apaga o rover na sua posição corrente
	
coluna_seguinte:						
	ADD	R2, R7							; para desenhar o rover na coluna seguinte (direita ou esquerda)
	JMP	mostra_rover					; vai desenhar o rover de novo
	POP R1

move_meteoro:
	PUSH R9
	MOV	 R9, 0							; som com número 0
	MOV  [TOCA_SOM], R9					; comando para tocar o som
	POP  R9
	POP  R0
	PUSH R2
	PUSH R4
	PUSH R9
	MOV  R9, ULTIMA_LINHA				; registo que guarda o valor da última linha
	CMP  R1, R9							; compara a linha atual e a última linha
	JNZ  move_normal					; se não for a última linha executa o movimento normal
	POP  R9						
	CALL apaga_ultima_linha				; o meteoro está na última linha, apagando-o
	MOV  R1, 0							; voltar a colocá-lo na posição inicial do ecrã
	MOV	 R4, DEF_METEORO_MAX			; guardar o formato do meteoro
	JMP  mostra_meteoro					


move_normal:							; movimento normal do meteoro com exceção da última linha 
	POP  R9
	SUB  R1, 5							; repor o valor da linha para desenhar o meteoro
	MOV  R2, COLUNA_METEORO		    	; coluna do meteoro
	MOV	 R4, DEF_METEORO_MAX			; endereço da tabela que define o meteoro
	CALL apaga_meteoro					; antes de mover temos que apagar o meteoro

linha_seguinte:
	ADD R1, 1							; vamos escrever o meteoro uma linha abaixo
	JMP mostra_meteoro


;;;;;;;;;;;;;;;;;;;;	LINHA 2		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

espera_tecla2:							; neste ciclo espera-se até uma tecla ser premida
	MOV R6, LINHA_TECLADO2				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0						
	JZ   espera_tecla3					; espera, enquanto não houver tecla

muda_valor_display:
	CMP R0, 1							; verifica se a tecla premida é a tecla 4
	JZ decrementa						; é a tecla 4
	CMP R0, 2							; verifica se a tecla premida é a tecla 5
	JZ incrementa						; é a tecla 5
	JMP espera_nao_tecla2				; caso em que não é nenhuma das teclas

decrementa:								; decrementa valor do display
	DEC R9
	MOV [R11], R9						; escreve o valor no display
	JMP espera_nao_tecla2

incrementa:								; incrementa valor do display
	INC R9
	MOV [R11], R9						; escreve o valor no display
	JMP espera_nao_tecla2

;;;;;;;;;;;;;;;;;;;;	LINHA 3		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

espera_tecla3:							; neste ciclo espera-se até uma tecla ser premida
	MOV R6, LINHA_TECLADO3				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0
	JZ   espera_tecla4					; espera, enquanto não houver tecla

;;;;;;;;;;;;;;;;;;;;	LINHA 4		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

espera_tecla4:							; neste ciclo espera-se até uma tecla ser premida
	MOV R6, LINHA_TECLADO4				; linha a testar no teclado
	CALL teclado						; leitura às teclas
	CMP	 R0, 0
	JZ   espera_tecla1					; espera, enquanto não houver tecla

inicia_jogo:							; verifica se a tecla premida é a de iniciar o jogo (tecla C)						
	CMP R0, TECLA_INICIO
	JZ	espera_tecla1					; vai para espera_tecla1 pois não é suposto realizar esta funcionalidade

suspende_jogo:							; verifica se a tecla premida é a de suspender o jogo (tecla D)
	CMP R0, TECLA_SUSPENDE
	JZ	espera_tecla1					; vai para espera_tecla1 pois não é suposto realizar esta funcionalidade

termina_jogo:							; verifica se a tecla premida é a de terminar o jogo (tecla E)
	CMP R0, TECLA_TERMINA
	JZ	espera_tecla1					; vai para espera_tecla1 pois não é suposto realizar esta funcionalidade



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

desenha_pixels_rover:      	  ; desenha os pixels do rover a partir da tabela
	MOV	 R3, [R4]			  ; obtém a cor do próximo pixel do rover
	CALL escreve_pixel		  ; escreve cada pixel do rover
	ADD	 R4, 2			      ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                ; próxima coluna
	SUB  R5, 1 		          ; menos uma coluna para tratar
	JNZ  desenha_pixels_rover ; continua até percorrer toda a largura do rover
	ADD  R1, 1				  ; proxima linha
    MOV  R2, R8				  ; repor o valor da coluna inicial
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

apaga_pixels_rover:         ; desenha os pixels do rover a partir da tabela
	MOV	 R3, 0				; cor para apagar o próximo pixel do rover
	CALL escreve_pixel		; escreve cada pixel do rover
	ADD	 R4, 2				; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1              ; próxima coluna
    SUB  R5, 1				; menos uma coluna para tratar
    JNZ  apaga_pixels_rover ; continua até percorrer toda a largura do objeto
	ADD  R1, 1				; proxima linha
    MOV  R2, R8				; repor o valor da coluna inicial
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

desenha_meteoro:
	PUSH R2
	MOV  R2, COLUNA_METEORO     ; o valor anteior de R2 é a coluna do Rover
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	MOV	 R5, [R4]		        ; obtém a largura do meteoro
	ADD  R4, 2				    ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]              ; obtém a altura do meteoro
	ADD	 R4, 2			        ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2					; guardar o valor da coluna atual

desenha_pixels_meteoro:         ; desenha os pixels do meteoro a partir da tabela
	MOV	 R3, [R4]			    ; obtém a cor do próximo pixel do meteoro
	CALL escreve_pixel		    ; escreve cada pixel do meteoro
	ADD	 R4, 2			        ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                  ; próxima coluna
	SUB  R5, 1 		            ; menos uma coluna para tratar
	JNZ  desenha_pixels_meteoro ; continua até percorrer toda a largura do meteoro
	ADD  R1, 1					; proxima linha
    MOV  R2, R8					; repor o valor da coluna inicial
    MOV  R5, LARGURA_MET_MAX	; repor a largura do meteoro para a proxima coluna
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
	MOV  R2, COLUNA_METEORO   ; o valor anteior de R2 é a coluna do Rover
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R8
	PUSH R10
	MOV	 R5, [R4]		      ; obtém a largura do meteoro
	ADD  R4, 2				  ; muda de linha da tabela pra obter a altura 
	MOV  R10, [R4]            ; obtém a altura do meteoro
	ADD	 R4, 2			      ; endereço da cor do 1º pixel (2 porque a largura é uma word)
    MOV  R8, R2				  ; guardar o valor da linha atual

apaga_pixels_meteoro:         ; desenha os pixels do meteoro a partir da tabela
	MOV	 R3, 0				  ; cor para apagar o próximo pixel do meteoro
	CALL escreve_pixel		  ; escreve cada pixel do meteoro
	ADD	 R4, 2				  ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R2, 1                ; próxima coluna
    SUB  R5, 1				  ; menos uma coluna para tratar
    JNZ  apaga_pixels_meteoro ; continua até percorrer toda a largura do meteoro
	ADD  R1, 1				  ; proxima linha
    MOV  R2, R8				  ; repor o valor da coluna inicial
    MOV  R5, LARGURA_MET_MAX  ; repor a largura do meteoro para a proxima coluna
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
	CALL escreve_pixel			; escrever o pixel do meteoro
	RET

; **********************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; **********************************************************************

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
