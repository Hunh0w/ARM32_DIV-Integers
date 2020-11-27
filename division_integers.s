SECTION INTVEC

B main

SECTION CODE

;###############################################
; Fonction division

div_func_boucle
CMP R3, R2
MOVLT PC, R5 ; Si jump effectué -> fin de la fonction, le résultat est dans R4
SUB R3, R3, R2
ADD R4, R4, #1
B div_func_boucle

div_func
POP {R3} ; Récupération des arguments via la pile
POP {R2} ;
POP {R5} ;
EOR R4, R4, R4
B div_func_boucle

;
;###############################################




main
LDR SP, =pile   ; Positionnement du Stack Pointer en bas de la pile
ADD SP, SP, #20 ;

LDR R2, diviseur
LDR R1, dividende
MOV R3, PC
ADD R3, R3, #16
PUSH {R3}
PUSH {R1}
PUSH {R2}
B div_func
STR R4, quotient
EOR R4, R4, R4
STR R4, diviseur
STR R4, dividende
B end


end ; FIN PROPRE
EOR R3, R3, R3 ; nettoyage des registres
EOR R5, R5, R5 ;
EOR R1, R1, R1 ;
EOR R2, R2, R2 ;
PUSH {R1,R2,R3} ; nettoyage de la pile
POP {R1,R2,R3}  ; 
B fin

fin
B fin

SECTION DATA
pile ALLOC32 5 ; pile de 20 octets
diviseur ASSIGN32 300
dividende ASSIGN32 3
quotient ALLOC32 1

;
; Algorithme de la Division en Java & C (traduit en ARM au dessus)
;
;long divide(long a, long b) {
;   long r = a;
;   long q = 0;
;
;   while (r >= b) {
;       r = r - b;
;       q = q + 1;
;   }
;   return q;
;}
