import Game from "./states/Game"


const canvas = document.getElementById("gamecanvas")
const context = canvas.getContext("2d")

const game = new Game({ context })

game.run()
