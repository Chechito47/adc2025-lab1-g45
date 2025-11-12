# ***INFORME LAB 1 ARQ DEL COMPUTADOR***
## Integrantes
- **Integrante 1: Lautaro Pinilla**
- **Integrante 2: Milena Juarez**

## Ejercicios resueltos:

## Cambios surgidos en base a las recomendaciones
### Tiempo de ejecucion de vivado
Aumentamos el tiempo de ejecucion a 50000ns para evitar errores en la generacion del mem.dump  
### regfile.sv
**Objetivo**: Implementar forwarding interno para resolver hazards.  
Se agregaron puertos para el Writeback:  
``` assembly
input logic we3_W,              //write enable desde Writeback
input logic [4:0] wa3_W,        //write address desde Writeback  
input logic [N-1:0] wd3_W,      //write data desde Writeback
```
Logica de lectura modificada para soportar forwarding:  
``` assembly
//--- Lectura asincrona con forwarding interno ---
//Verifico primero si es XZR, luego si hay forwarding desde Writeback, sino lectura normal
assign rd1 = (ra1 == 5'b11111) ? {N{1'b0}} :              //si es XZR => 0
             (we3_W && (ra1 == wa3_W)) ? wd3_W :          //si WB escribe este reg => forward
             REGS[ra1];                                   //si no => leer normal
    
assign rd2 = (ra2 == 5'b11111) ? {N{1'b0}} :              //si es XZR => 0
             (we3_W && (ra2 == wa3_W)) ? wd3_W :          //si WB escribe este reg => forward
             REGS[ra2];                                   //si no => leer normal
```
De esta forma cuando se lea un registro en Decode al mismo tiempo que dicho registro se escribe en Writeback retorna el valor actualizado.  
### decode.sv
**Objetivo**: Conectar las señales de forwarding desde Writeback al regfile.  
Se agregaron las conexiones nuevas del regfile:  
``` assembly
regfile registers(.clk(clk),
	              .we3(regWrite_D),
	              .we3_W(regWrite_D),              //mismo enable para forwarding
	              .ra1(instr_D[9:5]),
	              .ra2(ra2),
	              .wa3(wa3_D),
	              .wa3_W(wa3_D),              	   //mismo address para forwarding
	              .wd3(writeData3_D),
	              .wd3_W(writeData3_D),            //mismo data para forwarding
	              .rd1(readData1_D),
	              .rd2(readData2_D));
```
### fetch.sv
**Objetivo**: Actualizar nombres del adder debido a que el de la catedra usa otros nombres distintos al que teniamos:  
``` assembly
//ADDER: input -> [N-1:0] a, b; output -> [N-1:0] y
adder #(N) ADD (
    .a(PC_out),
    .b(64'h4),
    .y(adder_out)
);
```
### imem.sv
**Objetivo**: Soportar programas mas largos:  
``` assembly
//addr = 7 ya que 2^7 = 128
//addr sirve para indicar que palabra de esas 128 va a leer, es un indice nomas
input logic [6:0] addr
);
```
Esto es debido a que el codigo con NOPS es muy largo y 64 posiciones no es suficiente.  
### processor_arm.sv
**Objetivo**: Actualizar el tamaño del adder al nuevo:  
``` assembly
imem instrMem (.addr(IM_address[8:2]),
			   .q(q));
);
```
### top_tb.sv
**Objetivo**: Instanciar el dut y generar el dump correctamente.  
Cambianos la instanciacion del dut para evitar posibles errores:  
``` assembly
processor_arm dut (
    .i_sw(i_sw),
    .i_mclk(i_mclk),
    .i_reset(i_reset),
    .o_led(o_led),
    .D0_seg(D0_seg),
    .D1_seg(D1_seg),
    .D0_a(D0_a),
    .D1_a(D1_a),
    .dump(dump)
);
```
Nuestra secuencia de dump comienza en 0, da 10000ns para ejecutar el programa entero, activa el dump y da 100ns para generar el mem.dump  
``` assembly
initial
    begin
      dump = 0; i_mclk = 0; i_reset = 1; i_sw = 1;
      #20; i_reset = 0;
      #10000; dump = 1;
      #100;
      $stop;
	end 
```
### Codigo assembly con NOPS
**Objetivo**: Agregar NOPS para resolver los hazards.  
Los NOPS los agregamos de a 2. En total son 40 NOPS agregados.  
``` assembly
.text
	.org 0x0000

STUR X1, [X0, #0]      //guarda X1 en memoria base X0
STUR X2, [X0, #8]      //guarda X2 en memoria base X0
STUR X3, [X16, #0]     //guarda X3 en memoria base X16
ADD X3, X4, X5         //suma X4 y X5 en X3
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X3, [X0, #24]     //guarda X3 en memoria base X0
SUB X3, X4, X5         //resta X5 a X4 y guarda en X3
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X3, [X0, #32]     //guarda X3 en memoria base X0
SUB X4, XZR, X10       //carga el negado de X10 en X4
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X4, [X0, #40]     //guarda X4 en memoria base X
ADD X4, X3, X4         //suma X3 y X4 en X4
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X4, [X0, #48]     //guarda X4 en memoria base X0
SUB X5, X1, X3         //resta X3 a X1 y guarda en X5
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X5, [X0, #56]     //guarda X5 en memoria base X0
AND X5, X10, XZR       //pone en X5 el resultado de X10 AND 0
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X5, [X0, #64]     //guarda X5 en memoria base X0
AND X5, X10, X3        //pone en X5 el resultado de X10 AND X3
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X5, [X0, #72]     //guarda X5 en memoria base X0
AND X20, X20, X20      //mantiene X20 igual
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X20, [X0, #80]    //guarda X20 en memoria base X
ORR X6, X11, XZR       //copia X11 en X6
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X6, [X0, #88]     //guarda X6 en memoria base X0
ORR X6, X11, X3        //pone en X6 el resultado de X11 OR X
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X6, [X0, #96]     //guarda X6 en memoria base X0
LDUR X12, [X0, #0]     //carga en X12 desde memoria base X0
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
ADD X7, X12, XZR       //copia X12 en X7
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X7, [X0, #104]    //guarda X7 en memoria base X0
STUR X12, [X0, #112]   //guarda X12 en memoria base X0
ADD XZR, X13, X14      //suma X13 y X14 descartando el resultado
STUR XZR, [X0, #120]   //guarda 0 en memoria base X0
CBZ X0, L1             //salta a L1 si X0 es 0
ADD XZR, XZR, XZR      //NOP despues de CBZ
ADD XZR, XZR, XZR      //NOP despues de CBZ
STUR X21, [X0, #128]   //guarda X21 en memoria base X0
L1: STUR X21, [X0, #136] //guarda X21 en memoria base X0
ADD X2, XZR, X1        //copia X1 en X2
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
L2: SUB X2, X2, X1     //resta X1 a X2
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
ADD X24, XZR, X1       //copia X1 en X24
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
STUR X24, [X0, #144]   //guarda X24 en memoria base X0
ADD X0, X0, X8         //incrementa X0 con X8
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR	   //NOP
CBZ X2, L2			   //salta a L2 si X2 es 0
ADD XZR, XZR, XZR      //NOP despues de CBZ
ADD XZR, XZR, XZR      //NOP despues de CBZ
STUR X30, [X0, #144]   //guarda X30 en memoria base X0
ADD XZR, XZR, XZR      //NOP antes de modificar X30
ADD XZR, XZR, XZR      //NOP antes de modificar X30
ADD X30, X30, X30      //duplica X30
ADD XZR, XZR, XZR      //NOP despues de modificar X30
ADD XZR, XZR, XZR      //NOP despues de modificar X30
SUB X21, XZR, X21	   //invierte el signo de X21
ADD XZR, XZR, XZR      //NOP despues de modificar X21
ADD XZR, XZR, XZR      //NOP despues de modificar X21
ADD X30, X30, X20      //suma X30 con X20
ADD XZR, XZR, XZR      //NOP antes de usar X30 en LDUR
ADD XZR, XZR, XZR      //NOP antes de usar X30 en LDUR
LDUR X25, [X30, #-8]   //carga en X25 desde X30-8
ADD XZR, XZR, XZR      //NOP despues de LDUR
ADD XZR, XZR, XZR      //NOP despues de LDUR
ADD X30, X30, X30	   //duplica X30
ADD XZR, XZR, XZR      //NOP
ADD XZR, XZR, XZR      //NOP
ADD X30, X30, X16      //suma X30 con X16
ADD XZR, XZR, XZR      //NOP antes de usar X30 y X25
ADD XZR, XZR, XZR      //NOP antes de usar X30 y X25
STUR X25, [X30, #-8]   //guarda X25 en X30-8
finloop: CBZ XZR, finloop
```

# Codigo para una luz funcionando:
```assembly
.text
.org 0x0000
// X1=1, X15=15 (del regfile)
LSL X20, X1, X15      // X20 = 0x8000
ADD XZR, XZR, XZR     // NOP
ADD XZR, XZR, XZR     // NOP
ADD XZR, XZR, XZR     // NOP
STUR X1, [X20, #0]    // Escribir '1' en 0x8000 (LED 0)
ADD XZR, XZR, XZR     // NOP
ADD XZR, XZR, XZR     // NOP
finloop:
    CBZ XZR, finloop
```

```
ROM [0:7] ='{32'hd371c034,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000281,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};
```
# Codifo para 4 luces, 2 se apagan despues de un tiempo
```assembly
.text
.org 0x0000
// Preparar dirección GPIO
LSL X20, X1, X15      // X20 = 0x8000
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Crear patrón 1: 0x000F (LEDs 0-3)
LSL X21, X1, #3       // X21 = 0x0008
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ORR X21, X21, X1      // X21 = 0x0009
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
LSL X22, X1, #1       // X22 = 0x0002
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ORR X21, X21, X22     // X21 = 0x000B
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
LSL X22, X1, #2       // X22 = 0x0004
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ORR X21, X21, X22     // X21 = 0x000F
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Encender LEDs 0-3
STUR X21, [X20, #0]
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// DELAY (~30 instrucciones)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
// ... (agrega más NOPs si quieres más delay)

// Crear patrón 2: 0x000C (solo LEDs 2-3)
LSL X23, X1, #2       // X23 = 0x0004
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
LSL X24, X1, #3       // X24 = 0x0008
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ORR X23, X23, X24     // X23 = 0x000C
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Apagar LEDs 0-1 (escribir nuevo patrón)
STUR X23, [X20, #0]
ADD XZR, XZR, XZR     // NOP x3
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

finloop:
    CBZ XZR, finloop
```

```ROM [0:53] ='{32'hD371C034,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37d3c35,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa0102b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37F3C36,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1602b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37E3C36,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1602b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000295,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37E3C37,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37D3C38,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1802f7,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000297,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};
```
