import { clamp } from "../helpers"
import * as Config from "../const/Config"
import { circlesAreColliding } from "../helpers"
import * as keyboard from "../interaction/keyboard"

// Data
import levels from "../levels.json"

// Sprites
import Background from "../objects/Background"
import InfoOverlay from "../objects/InfoOverlay"
import Planet from "../objects/Planet"
import Spaceship from "../objects/Spaceship"

// Internal consts
const updateMs = 10
const homePlanetColor = "#0095DD"
const safeSpace = { x: Config.gameWidth / 2, y: Config.gameHeight / 2, radius: 2000 }

export default class Game {
    constructor({
        context,
    } = {}) {
        this.context = context

        this.renderList = []
        this.planets = []
        this.isRunning = false
        this.currentLevel = 0
        this.score = 0

        this.spaceship = new Spaceship({ context })
        this.infoOverlay = new InfoOverlay({ context })

        this.createLevel(this.currentLevel)

        keyboard.onSpacePressed(() => {
            if (this.isGameOver || this.isRunning) {
                this.restartLevel()
            } else {
                this.launchSpaceship()
            }
        })
    }

    restartLevel() {
        if (this.currentLevel > levels.length - 1) {
            this.currentLevel = 0
            this.score = 0
            this.infoOverlay.score = this.score
        }
        this.createLevel(this.currentLevel)
        this.infoOverlay.message = null
        this.spaceship.isAdjusting = true
        this.isGameOver = false
        this.isRunning = false
    }

    launchSpaceship() {
        this.spaceship.momentum = this.spaceship.launchMomentum
        this.spaceship.angle = this.spaceship.launchAngle
        this.spaceship.isAdjusting = false
        this.isRunning = true
        this.score++
        this.infoOverlay.score = this.score
        this.infoOverlay.message = null
    }

    run() {
        setInterval(this.update.bind(this), updateMs)
        requestAnimationFrame(this.render.bind(this))
    }

    update() {
        const { isRunning, spaceship, planets } = this

        if (isRunning) {
            this.checkCollisions()
            spaceship.update(planets)
        } else {
            // Handle user nput
            if (keyboard.leftPressed) {
                spaceship.launchAngle -= Config.angleDelta
            } else if (keyboard.rightPressed) {
                spaceship.launchAngle += Config.angleDelta
            } else if (keyboard.upPressed) {
                spaceship.launchMomentum = clamp(spaceship.launchMomentum + Config.momentumDelta, Config.momentumMin, Config.momentumMax)
            } else if (keyboard.downPressed) {
                spaceship.launchMomentum = clamp(spaceship.launchMomentum - Config.momentumDelta, Config.momentumMin, Config.momentumMax)
            }
        }
    }

    render() {
        this.renderList.forEach(sprite => sprite.render())
        requestAnimationFrame(this.render.bind(this))
    }

    createLevel(num) {
        const { context, spaceship, infoOverlay } = this
        const level = levels[num]

        const gamePaddingX = Config.gameWidth / (level.gridWidth + 1)
        const gamePaddingY = Config.gameHeight / (level.gridHeight + 1)

        const xDelta = (Config.gameWidth - (gamePaddingX * 2)) / (level.gridWidth - 1)
        const yDelta = (Config.gameHeight - (gamePaddingY * 2)) / (level.gridHeight - 1)

        this.renderList = []
        this.planets = []

        // Background
        this.renderList.push(new Background({ context }))

        // Planets
        level.planets.forEach((planet, idx) => {
            const planetSprite = new Planet({
                context,
                x: gamePaddingX + planet.col * xDelta,
                y: gamePaddingY + planet.row * yDelta,
                name: planet.name || `Planet ${idx + 1}`,
                color: planet.color,
                mass: planet.mass,
            })

            this.renderList.push(planetSprite)
            this.planets.push(planetSprite)
        })

        // Goal
        this.goal = new Planet({
            context,
            x: gamePaddingX + level.goalCol * xDelta,
            y: gamePaddingY + level.goalRow * yDelta,
            color: homePlanetColor,
        })
        this.renderList.push(this.goal)
        this.planets.push(this.goal)

        // Spaceship
        spaceship.x = gamePaddingX + level.startCol * xDelta
        spaceship.y = gamePaddingY + level.startRow * yDelta
        this.renderList.push(spaceship)

        // Info overlay
        infoOverlay.levelName = `Level ${num + 1}: ${level.name}`
        this.renderList.push(infoOverlay)
    }

    checkCollisions() {
        const { spaceship, planets, goal, score } = this

        // Stop if reached home
        if (circlesAreColliding(spaceship, goal)) {
            this.stop(this.currentLevel === levels.length - 1 ? `Final score: ${score}` : "You got home!")
            this.currentLevel++
            return
        }

        // Stop if lost in space
        if (!circlesAreColliding(spaceship, safeSpace)) {
            return this.stop("Lost in space")
        }

        planets.forEach(planet => {
            // Stop if crash
            if (circlesAreColliding(spaceship, planet)) {
                return this.stop(`You crashed into ${planet.name}`)
            }
        })
    }

    stop(message) {
        this.infoOverlay.message = message
        this.isRunning = false
        this.isGameOver = true
    }
}
