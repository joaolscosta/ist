; *********************************************************************************
; * IST-UL
; * Modulo:    lab7-processos-boneco-teclado-continuo.asm
; * Descrição: Este programa ilustra a utilização do teclado em modo "tecla a tecla" e
; *			em modo "continuo".
; *			As teclas C e D fazem subir ou descer o valor nos displays, 
; *			uma vez por cada toque numa tecla.
; *			A tecla E causa o movimento do boneco no ecrã em modo "contínuo", 
; *			enquanto a tecla estiver carregada
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
DEFINE_LINHA    		EQU 600AH      ; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU 600CH      ; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU 6012H      ; endereço do comando para escrever um pixel
APAGA_AVISO     		EQU 6040H      ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 		EQU 6002H      ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO  EQU 6042H      ; endereço do comando para selecionar uma imagem de fundo

DISPLAYS			EQU  0A000H	; endereço do periférico que liga aos displays
TEC_LIN			EQU  0C000H	; endereço das linhas do teclado (periférico POUT-2)
TEC_COL			EQU  0E000H	; endereço das colunas do teclado (periférico PIN)
LINHA_TECLADO		EQU 	8		; linha a testar (4ª linha, 1000b)
MASCARA			EQU	0FH		; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
TECLA_C			EQU 	1		; tecla na primeira coluna do teclado (tecla C)
TECLA_D			EQU 	2		; tecla na segunda coluna do teclado (tecla D)
TECLA_E			EQU 	4		; tecla na terceira coluna do teclado (tecla E)

LINHA        		EQU  16        ; linha do boneco (a meio do ecrã))
COLUNA			EQU  30        ; coluna do boneco (a meio do ecrã)

MIN_COLUNA		EQU  0		; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		EQU  63        ; número da coluna mais à direita que o objeto pode ocupar

LARGURA			EQU	5		; largura do boneco
COR_PIXEL			EQU	0FF00H	; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)

; *********************************************************************************
; * Dados 
; *********************************************************************************
	PLACE       1000H

; Reserva do espaço para as pilhas dos processos
	STACK 100H			; espaço reservado para a pilha do processo "programa principal"
SP_inicial_prog_princ:		; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H			; espaço reservado para a pilha do processo "teclado"
SP_inicial_teclado:			; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H			; espaço reservado para a pilha do processo "boneco"
SP_inicial_boneco:			; este é o endereço com que o SP deste processo deve ser inicializado
							
tecla_carregada:
	LOCK 0				; LOCK para o teclado comunicar aos restantes processos que tecla detetou,
						; uma vez por cada tecla carregada
							
tecla_continuo:
	LOCK 0				; LOCK para o teclado comunicar aos restantes processos que tecla detetou,
						; enquanto a tecla estiver carregada
							
evento_int_0:
	LOCK 0				; LOCK para a rotina de interrupção comunicar ao processo boneco que a interrupção ocorreu
							
DEF_BONECO:				; tabela que define o boneco (cor, largura, pixels)
	WORD		LARGURA
	WORD		COR_PIXEL, 0, COR_PIXEL, 0, COR_PIXEL		; # # #   as cores podem ser diferentes
     

; *********************************************************************************
; * Código
; *********************************************************************************
PLACE   0                     ; o código tem de começar em 0000H
inicio:
	MOV  SP, SP_inicial_prog_princ		; inicializa SP do programa principal
                            
     MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
     MOV  [APAGA_ECRÃ], R1	; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
	MOV	R1, 0			; cenário de fundo número 0
     MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	MOV	R7, 1			; valor a somar à coluna do boneco, para o movimentar
     
	; cria processos. O CALL não invoca a rotina, apenas cria um processo executável
	CALL	teclado			; cria o processo teclado
	CALL	boneco			; cria o processo boneco

; o resto do programa principal é também um processo (neste caso, trata dos displays)

	MOV  R2, 0			; valor do contador, cujo valor vai ser mostrado nos displays
	MOV  R0, DISPLAYS        ; endereço do periférico que liga aos displays
atualiza_display:	
	MOVB [R0], R2            ; mostra o valor do contador nos displays
obtem_tecla:	
	MOV	R1, [tecla_carregada]	; bloqueia neste LOCK até uma tecla ser carregada
	CMP	R1, TECLA_C		; é a coluna da tecla C?
	JNZ	testa_D
	ADD  R2, 1               ; aumenta o contador
	JMP	atualiza_display
testa_D:	
	CMP	R1, TECLA_D		; é a coluna da tecla D?
	JNZ	obtem_tecla		; se não, ignora a tecla e espera por outra
	SUB  R2, 1               ; diminui o contador
	JMP	atualiza_display	; processo do programa principal nunca termina


; **********************************************************************
; Processo
;
; TECLADO - Processo que deteta quando se carrega numa tecla na 4ª linha
;		  do teclado e escreve o valor da coluna num LOCK.
;
; **********************************************************************

PROCESS SP_inicial_teclado	; indicação de que a rotina que se segue é um processo,
						; com indicação do valor para inicializar o SP
teclado:					; processo que implementa o comportamento do teclado
	MOV  R2, TEC_LIN		; endereço do periférico das linhas
	MOV  R3, TEC_COL		; endereço do periférico das colunas
	MOV  R5, MASCARA		; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
	MOV  R1, LINHA_TECLADO	; testar a linha 4 

espera_tecla:				; neste ciclo espera-se até uma tecla ser premida

	YIELD				; este ciclo é potencialmente bloqueante, pelo que tem de
						; ter um ponto de fuga (aqui pode comutar para outro processo)

	MOVB [R2], R1			; escrever no periférico de saída (linhas)
	MOVB R0, [R3]			; ler do periférico de entrada (colunas)
	AND  R0, R5			; elimina bits para além dos bits 0-3
	CMP  R0, 0			; há tecla premida?
	JZ   espera_tecla		; se nenhuma tecla premida, repete
						
	MOV	[tecla_carregada], R0	; informa quem estiver bloqueado neste LOCK que uma tecla foi carregada
							; (o valor escrito é o número da coluna da tecla no teclado)

ha_tecla:					; neste ciclo espera-se até NENHUMA tecla estar premida

	YIELD				; este ciclo é potencialmente bloqueante, pelo que tem de
						; ter um ponto de fuga (aqui pode comutar para outro processo)

	MOV	[tecla_continuo], R0	; informa quem estiver bloqueado neste LOCK que uma tecla está a ser carregada
							; (o valor escrito é o número da coluna da tecla no teclado)
     MOVB [R2], R1			; escrever no periférico de saída (linhas)
     MOVB R0, [R3]			; ler do periférico de entrada (colunas)
	AND  R0, R5			; elimina bits para além dos bits 0-3
     CMP  R0, 0			; há tecla premida?
     JNZ  ha_tecla			; se ainda houver uma tecla premida, espera até não haver

	JMP	espera_tecla		; esta "rotina" nunca retorna porque nunca termina
						; Se se quisesse terminar o processo, era deixar o processo chegar a um RET


; **********************************************************************
; Processo
;
; BONECO - Processo que desenha um boneco e o move horizontalmente, com
;		 temporização marcada pela interrupção 0
;
; **********************************************************************

PROCESS SP_inicial_boneco	; indicação de que a rotina que se segue é um processo,
						; com indicação do valor para inicializar o SP
boneco:					; processo que implementa o comportamento do boneco
	; desenha o boneco na sua posição inicial
     MOV  R1, LINHA			; linha do boneco
	MOV	R2, COLUNA
	MOV	R4, DEF_BONECO		; endereço da tabela que define o boneco
ciclo_boneco:
	CALL	desenha_boneco		; desenha o boneco a partir da tabela
espera_movimento:
	MOV	R3, [tecla_continuo]	; lê o LOCK e bloqueia até o teclado escrever nele novamente
	CMP	R3, TECLA_E		; é a coluna da tecla E?
	JNZ	espera_movimento	; se não é, ignora e continua à espera

	CALL	apaga_boneco		; apaga o boneco na sua posição corrente
	
	MOV	R6, [R4]			; obtém a largura do boneco
	CALL	testa_limites		; vê se chegou aos limites do ecrã e nesse caso inverte o sentido
	ADD	R2, R7			; para desenhar objeto na coluna seguinte (direita ou esquerda)
	JMP	ciclo_boneco		; esta "rotina" nunca retorna porque nunca termina
						; Se se quisesse terminar o processo, era deixar o processo chegar a um RET


; **********************************************************************
; DESENHA_BONECO - Desenha um boneco na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o boneco
;
; **********************************************************************
desenha_boneco:
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	MOV	R5, [R4]			; obtém a largura do boneco
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels:       		; desenha os pixels do boneco a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do boneco
	CALL	escreve_pixel		; escreve cada pixel do boneco
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels      ; continua até percorrer toda a largura do objeto
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	RET

; **********************************************************************
; APAGA_BONECO - Apaga um boneco na linha e coluna indicadas
;			  com a forma definida na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o boneco
;
; **********************************************************************
apaga_boneco:
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	MOV	R5, [R4]			; obtém a largura do boneco
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels:       		; desenha os pixels do boneco a partir da tabela
	MOV	R3, 0			; cor para apagar o próximo pixel do boneco
	CALL	escreve_pixel		; escreve cada pixel do boneco
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels      ; continua até percorrer toda a largura do objeto
	POP	R5
	POP	R4
	POP	R3
	POP	R2
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
	MOV  [DEFINE_COLUNA], R2		; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET


; **********************************************************************
; TESTA_LIMITES - Testa se o boneco chegou aos limites do ecrã e nesse caso
;			   inverte o sentido de movimento
; Argumentos:	R2 - coluna em que o objeto está
;			R6 - largura do boneco
;			R7 - sentido de movimento do boneco (valor a somar à coluna
;				em cada movimento: +1 para a direita, -1 para a esquerda)
;
; Retorna: 	R7 - novo sentido de movimento (pode ser o mesmo)	
; **********************************************************************
testa_limites:
	PUSH	R5
	PUSH	R6
testa_limite_esquerdo:		; vê se o boneco chegou ao limite esquerdo
	MOV	R5, MIN_COLUNA
	CMP	R2, R5
	JLE	inverte_para_direita
testa_limite_direito:		; vê se o boneco chegou ao limite direito
	ADD	R6, R2			; posição a seguir ao extremo direito do boneco
	MOV	R5, MAX_COLUNA
	CMP	R6, R5
	JGT	inverte_para_esquerda
	JMP	sai_testa_limites	; entre limites. Mantém o valor do R7

inverte_para_direita:
	MOV	R7, 1			; passa a deslocar-se para a direita
	JMP	sai_testa_limites
inverte_para_esquerda:
	MOV	R7, -1			; passa a deslocar-se para a esquerda
sai_testa_limites:	
	POP	R6
	POP	R5
	RET

