// Temporizador para cuando la pestaña está oculta: el navegador deja de llamar a
// requestAnimationFrame y frena los setInterval de la página, pero no los de un Worker.
// En juego en red así este dispositivo sigue enviando sus entradas y no bloquea a los demás.
let id = null;
onmessage = (e) => {
  clearInterval(id);
  id = e.data ? setInterval(() => postMessage(0), e.data) : null;
};
