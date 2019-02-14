import { gameWidth, gameHeight } from "../const/Config"

export default class LevelPoster {
    constructor({
        context,
        levelName = "",
        message = "",
        score = 0,
    } = {}) {
        this.context = context
        this.levelName = levelName
        this.message = message
        this.score = score
    }

    render() {
        const { context, levelName, score, message } = this

        if (levelName) {
            context.font = "28px sans-serif"
            context.fillStyle = "#FFF"
            context.fillText(levelName, 20, 40)
        }

        context.font = "28px sans-serif"
        const scoreText = `Score: ${score}`
        const text = context.measureText(scoreText)
        context.fillStyle = "#FFF"
        context.fillText(scoreText, gameWidth - text.width - 20, 40)

        if (message) {
            context.font = "48px sans-serif"
            const text = context.measureText(message)
            context.fillStyle = "#FFF"
            context.fillText(message, (gameWidth / 2) - (text.width / 2), gameHeight / 2)

            if (message !== this.prevMessage) {
                clearTimeout(this.messageTimeout)
                this.messageTimeout = setTimeout(() => this.message = "", 2000)
                this.prevMessage = message
            }
        }
    }

    update() {
    }
}
