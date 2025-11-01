[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/ItraukZ2)
# Arquitectura de Computadoras - FAMAF - UNC

## Ej 2 practico 2:
### Ej 2a:
``` assembly
.text
	.org 0x0000
	
	ADD X20, XZR, XZR       // X20 = 0 (valor a guardar)
	ADD X21, XZR, XZR       // X21 = 0 (direccion)
	ADD X22, XZR, XZR       // X22 = 0 (contador)
	
loop:
	STUR X20, [X21, #0]     // Guardar valor
	ADD X20, X20, X1        // Incrementar valor (X1=1)
	ADD X21, X21, X8        // Incrementar direccion (X8=8)
	ADD X22, X22, X1        // Incrementar contador
	SUB X23, X22, X10       // Comparar contador con 10
	ADD XZR, XZR, XZR		// NOP
	ADD XZR, XZR, XZR		// NOP
	ADD XZR, XZR, XZR		// NOP
	CBZ X23, end            // Si contador==10, salir
	SUB X23, X23, X23       // NOP (X23 = 0)
	SUB X23, X23, X23       // NOP
	SUB X23, X23, X23       // NOP
	CBZ XZR, loop           // Branch incondicional
	
end:
	CBZ XZR, end            // Loop infinito para detener ejecucion
```
Como el micro no tiene deteccion de hazards ni forwarding,hacemos una implementacion desenrollada garantizando que funcione sin depender de branches condicionales.  
## Ej 2b:
```assembly
.text
	.org 0x0000
	
	// ========== EJERCICIO 2A: Inicializar MEM[0..9] con sus indices ==========
	
	ADD X20, XZR, XZR       // X20 = 0 (contador)
	STUR X20, [X0, #0]      // MEM[0] = 0
	ADD X20, X20, X1        // X20 = 0 + 1 = 1 (X1 vale 1)
	STUR X20, [X0, #8]      // MEM[1] = 1
	ADD X20, X20, X1        // X20 = 1 + 1 = 2
	STUR X20, [X0, #16]     // MEM[2] = 2
	ADD X20, X20, X1        // X20 = 2 + 1 = 3
	STUR X20, [X0, #24]     // MEM[3] = 3
	ADD X20, X20, X1        // X20 = 3 + 1 = 4
	STUR X20, [X0, #32]     // MEM[4] = 4
	ADD X20, X20, X1        // X20 = 4 + 1 = 5
	STUR X20, [X0, #40]     // MEM[5] = 5
	ADD X20, X20, X1        // X20 = 5 + 1 = 6
	STUR X20, [X0, #48]     // MEM[6] = 6
	ADD X20, X20, X1        // X20 = 6 + 1 = 7
	STUR X20, [X0, #56]     // MEM[7] = 7
	ADD X20, X20, X1        // X20 = 7 + 1 = 8
	STUR X20, [X0, #64]     // MEM[8] = 8
	ADD X20, X20, X1        // X20 = 8 + 1 = 9
	STUR X20, [X0, #72]     // MEM[9] = 9
	
	// ========== EJERCICIO 2B: Sumar MEM[0..9] y guardar en MEM[10] ==========
	
	ADD X20, XZR, XZR       // X20 = 0 (reiniciar contador)
	LDUR X21, [X0, #0]      // X21 = MEM[0] = 0
	ADD X20, X20, X21       // X20 = 0 + 0 = 0
	LDUR X21, [X0, #8]      // X21 = MEM[1] = 1
	ADD X20, X20, X21       // X20 = 0 + 1 = 1
	LDUR X21, [X0, #16]     // X21 = MEM[2] = 2
	ADD X20, X20, X21       // X20 = 1 + 2 = 3
	LDUR X21, [X0, #24]     // X21 = MEM[3] = 3
	ADD X20, X20, X21       // X20 = 3 + 3 = 6
	LDUR X21, [X0, #32]     // X21 = MEM[4] = 4
	ADD X20, X20, X21       // X20 = 6 + 4 = 10
	LDUR X21, [X0, #40]     // X21 = MEM[5] = 5
	ADD X20, X20, X21       // X20 = 10 + 5 = 15
	LDUR X21, [X0, #48]     // X21 = MEM[6] = 6
	ADD X20, X20, X21       // X20 = 15 + 6 = 21
	LDUR X21, [X0, #56]     // X21 = MEM[7] = 7
	ADD X20, X20, X21       // X20 = 21 + 7 = 28
	LDUR X21, [X0, #64]     // X21 = MEM[8] = 8
	ADD X20, X20, X21       // X20 = 28 + 8 = 36
	LDUR X21, [X0, #72]     // X21 = MEM[9] = 9
	ADD X20, X20, X21       // X20 = 36 + 9 = 45
	STUR X20, [X0, #80]     // MEM[10] = 45 (resultado final)
	
end:
	CBZ XZR, end            // Loop infinito para detener ejecucion
```
### Ej 2c:
```assembly
.text
	.org 0x0000
	
	ADD X20, XZR, XZR       // X20 = 0 (inicializa el contador en 0)

	ADD X20, X20, X16       // X20 = X20 + X16 (suma 1° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (2° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (3° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (4° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (5° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (6° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (7° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (8° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (9° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (10° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (11° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (12° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (13° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (14° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (15° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (16° vez)
	ADD X20, X20, X16       // X20 = X20 + X16 (17° vez)
	
	STUR X20, [X0, #0]      // Guarda el resultado final de X20 en la direccion apuntada por X0

end:
	CBZ XZR, end            // Loop infinito para detener ejecucion
```
## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas
