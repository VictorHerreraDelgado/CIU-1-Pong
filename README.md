# CIU-1-Pong
### Autor: Víctor Herrera Delgado
Un programa en Processing que emula el famoso juego Pong con algunas variaciones realizadas por el autor.

# Descripción
Primero una breve introducción al funcionamiento de la aplicación.
Como se denota en el párrafo anterior, se ha realizado una copia con toques personales del famoso y antiguo juego conocido como "Pong", véase un juego de dos jugadores en el cual cada uno controla una barra con la cual deben impedir que una bola atraviese su campo y entre en "la portería", así como intentando marcar el punto al rival. 

### Primera pantalla 
La aplicación mostrará una primera pantalla de inicio con un menú que mostrará dos opciones: Jugar y Salir. La primera opción iniciará el juego, mientras que la segunda te hará salir de la aplicación. La opción actual es destacada por un círculo a su izquierda. Podrá cambiar la opción con las flechas de control del teclado y seleccionarla al pulsar la tecla <<Enter>>.

### Juego
El juego se mantendrá activo hasta que uno de los jugadores llegue a 7 puntos. Al comienzo de cada ronda, sonará un pitido que cuando acabe pondrá en marcha el juego. Hasta que no acabe, ni la bola ni los jugadores podrán moverse.

Durante la ejecución del juego cada jugador podrá mover su pala haciendo uso de las respectivas teclas: W y S para los movimientos de arriba y abajo del jugador a la izquierda y lo mismo con las flechas de control para el jugador de la derecha.

La pelota siempre saldrá del centro de la ventana con dirección y velocidad aleatorias, aunque por elección del programador, se ha decidido orientar la pelota al usuario que haya perdido el último punto para darle la opción de ser el primero en direccionarla. Esta podrá rebotar en las paredes horizontales y en los pads únicamente, dando un punto al jugador correspondiente cuando llegue a los límites verticales. Para las "palas" controladas por cada jugador se realizó un sistema de rebotes similar al de las paredes, aunque con algunas modificaciones realizadas para intentar aportar una experiencia más competitiva al juego:
- 1. Cuando la pala se encuentra en reposo, el rebote será igual al usado con las paredes.
- 2. Si la pala está en movimiento cuando se le da, se podrá cambiar su trayectoria (arriba y abajo) así como afectarla si se mueve horizontalmente.
- 3. Si golpea una de las esquinas de la pala, el movimiento vertical será disminuido si choca de entrada (ejemplo: chocar con una esquina superior viniendo desde arriba) o aumentado si choca de salida (ejemplo chocar con una esquina inferior viniendo desde arriba). En estos golpes no se tiene en cuenta el movimiento de la pala.
Todo esto ha sido modificado para poder aportar un mayor sentimiento de competición entre los jugadores, al tener que predecir por donde mandará la bola el siguiente jugador y teniendo que adaptarse ha una velocidad creciente de la pelota (hasta un límite para no presentar problemas de colisión).

Por cada bola que llegue a la pared tras un jugador hará que se incremente la puntuación del contrario y que se vuelva a lanzar la bola desde el centro (como ya se mencionó, hacia el jugadoir que perdió el punto).

Destaco también la posibilidad de pulsar la tecla P para pausar o reanudar la partida en cualquier momento.

### Fin del juego
Cuando se llega a 7 puntos por parte de cualquiera de los dos jugadores, el juego parará, mostrando quien es el ganador. La ventana mostrará entonces un menú similar al de la primera pantalla con las mismas opciones pero de menor tamaño. Al pulsar jugar se reiniciarán  las variables a sus valores originales.

# Código
Pasaré a explicar el código realizado. Este está formado por dos ficheros, siendo el principal de ellos <<pong_v0.pde>> y uno auxiliar <<menu.pde>>. Este segundo archivo simplemente incorpora una clase dedicada a mostrar y hacer los cambios necesarios a la vista del menú, así que se saltará su explicación.

### setup()
Es la parte del código encargada de inicializar las variables principales para el funcionamiento de la aplicación

### draw()
Se encarga no solo de mostrar cada elemento en la ventana sino también de llamar a los correspondientes métodos para actualizar y comprobar las variables de juego.
Usando la variable <<state>> definimos el estado del juego en el que se encuentra:
  - state = 0 : El juego aun no ha empezado y se se encuentra en la ventana principal. Muestra el menú al jugador y está a la espera de que el usuario elija opción.
  - state = 1 : El juego ha comenzado y está en ejecución. Se procederá a la muestra de cada elemento en la pantalla de manera normal así como a usar las funciones que comprueban los rebotes y demás aspectos de la ejecución de la partida.
  - state = 2 : El juego ha terminado y muestra la puntuación de los jugadores, además del menú que dejará al usuario elegir si jugar de nuevo o salir.
  
En caso de estar en juego, se comprobará la variable <<pause>> para ver si se muestra el mensaje de pausa en pantalla así como la variable <<starting>>, para ver si se dejará un tiempo de espera (normalmente usado entre ronda y ronda de juego).
  
### Funciones de colisiones
Las funciones bounceOnWall(), ballGoaled() y bounceOnPad() se encargan de los botes en los distintos elementos. Para la segunda simplemente se aplica la función de aumentar la puntuación y reiniciar la ronda.
Para la tercera, se ha tenido en cuenta también la capacidad de golpear las esquinas (unicamente las delanteras) y la capacidad de redireccionar la pelota.

### Funciones de actualización
Las funciones updateBall() y updatePads() actualizan los elementos dependiendo de la velocidad que lleve impuesta la pelota en el primer caso o lo tecleado por el usuario en el segundo.

Por otro lado, anotherRound() y restartValues() se encargan de el reinicio de la ronda y de la partida respectivamente.

Finalmente, pause() controla la variable del mismo nombre y para o reanuda la partida dependiendo de esta.

### Control del teclado
Por último, cabe mencionar el control para los inputs en el teclado del usuario, cada uno con su respectivo desencadenamiento, destacando el guardado del movimiento de las palas en vectores para consultarlos en las funciones de actualización y rebote.


# Funcionamiento en vivo
En el gif a continuación mostramos el funcionamiento del juego, aunque cabe destacar que **la velocidad en el gif es inferior a la velocidad en ejecución**.

![](funcionamiento.gif)

# Ejecución
Para poder ejecutarlo en processing descargue la carpeta entera que se encuentra en el repositorio.

# Elementos externos
Se ha hecho uso de distintos sonidos para incluirlos cuando una pelota rebota,cuando se gana un punto o cuando se gana una partida. Estos estan incluidos en el repositorio y fueron usados mediante la librería sound de processing.
NFF-bounce-02.wav y NFF-lose.wav han sido obtenidos por el sitio web www.noiseforfun.com, que ofrece distintos sonidos para videojuegos de manera gratuita.
alexPi.mp3 y alexPo.mp3 han sido grabados y editados usando la herramienta de edición de audio online https://twistedwave.com/online.
