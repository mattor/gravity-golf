import { gameWidth, gameHeight } from "./const/Config"
import Game from "./states/Game"

const canvas = document.createElement("canvas")
canvas.width = gameWidth
canvas.height = gameHeight

const contentEl = document.getElementById("container")
contentEl.appendChild(canvas)

const context = canvas.getContext("2d")
const game = new Game({ context })
game.run()
