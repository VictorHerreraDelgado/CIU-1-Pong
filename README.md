# CIU-1-Pong
### Autor Víctor Herrera Delgado
Un programa en Processing que emula el famoso juego Pong con algunas variaciones realizadas por el autor.

## Descripción
Primero una breve introducción al funcionamiento de la aplicación.
Como se denota en el párrafo anterior, se ha realizado una copia con toques personales del famoso y antiguo juego conocido como "Pong", véase un juego de dos jugadores en el cual cada uno controla una barra con la cual deben impedir que una bola atraviese su campo y entre en "la portería", así como intentando marcar el punto al rival.

### Primera pantalla
La aplicación mostrará una primera pantalla de inicio que pedirá clicar sobre el programa para empezar la partida. Esto se ha hecho así por dos razones: 
- 1. Que los jugadores tengan tiempo para prepararse y ver las instrucciones que esta pantalla muestra.
- 2. Que al hacer click en la ventana se centre el foco sobre esta y por lo tanto registre bien las teclas pulsadas.

### Juego
El juego se mantendrá activo hasta que uno de los jugadores llegue a 7 puntos.
Durante la ejecución del juego cada jugador podrá mover su pala haciendo uso de las respectivas teclas: W y S para los movimientos de arriba y abajo del jugador a la izquierda y lo mismo con las flechas de control para el jugador de la derecha.

La pelota siempre saldrá del centro de la ventana con dirección y velocidad aleatorias, aunque por elección del programador, se ha decidido orientar la pelota al usuario que haya perdido el último punto. Esta podrá rebotar en las paredes horizontales y en los pads únicamente, dando un punto al jugador correspondiente cuando llegue a los límites verticales. Para las "palas" controladas por cada jugador se realizó un sistema de rebotes similar al de las paredes, aunque con algunas modificaciones realizadas para intentar aportar una experiencia más competitiva al juego:

- 1. Cuendo la pala se encuentra quieta, el rebote será igual al usado con las paredes.
- 2. Si la pala está en movimiento cuando se le da, se podrá cambiar su trayectoria (arriba y abajo) así como afectarla si se mueve horizontalmente.
- 3. Si golpea una de las esquinas de la pala, el movimiento vertical será disminuido si choca de entrada (ejemplo: chocar con una esquina superior viniendo desde arriba) o aumentado si choca de salida (ejemplo chocar con una esquina inferior viniendo desde arriba). En estos golpes no se tiene en cuenta el movimiento de la pala.
Todo esto ha sido modificado para poder aportar un mayor sentimiento de competición entre los jugadores, al tener que predecir por donde mandará la bola el siguiente jugador y teniendo que adaptarse ha una velocidad creciente de la pelota (hasta un límite para no presentar problemas de colisión).

Por cada bola que llegue a la pared tras un jugador hará que se incremente la puntuación del contrario y que se vuelva a lanzar la bola desde el centro (como ya se mencionó, hacia el jugadoir que perdió el punto.).

### Fin del juego
Cuando se llega a 7 puntos por parte de cualquiera de los dos jugadores, el juego parará, mostrando quien es el ganador y parando el juego. La ventana también sugerirá hacer click con el ratón para comenzar una nueva partida, reiniciando las variables a sus valores originales.

### Elementos externos
Se ha hecho uso de distintos sonidos para incluirlos cuando una pelota rebota o cuando se gana un punto. Estos estan incluidos en el repositorio y fueron usados mediante la librería sound de processing.
NFF-bounce-02.wav y NFF-lose.wav han sido obtenidos por el sitio web www.noiseforfun.com, que ofrece distintos sonidos para videojuegos de manera gratuita.
alexPi.mp3 y alexPo.mp3 han sido grabados y editados usando la herramienta de edición de audio online https://twistedwave.com/online.

En cuanto a la imagen usada para la muestra de instrucciones, esta fue creada por el alummno en cuestión mediante la herramienta de dibujo Jump Paint de la empresa Medibang (https://medibangpaint.com/es/jumppaint/).
Esta imagen también se encuentra en el repositorio y fue añadida al programa usando `loadImage()`

## Funcionamiento en vivo
![](funcionamiento.gif)
