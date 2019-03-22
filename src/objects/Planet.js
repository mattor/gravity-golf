import { earthMass, spriteScaleFactor } from "../const/Config"

export default class Planet {
    constructor({
        name = "planet",
        context,
        x,
        y,
        mass = earthMass,
        color = "#444",
    } = {}) {
        this.context = context
        this.x = x
        this.y = y
        this.mass = mass
        this.name = name
        this.color = color

        this.radius = Math.cbrt(this.mass * 3 / 4 * Math.PI) * spriteScaleFactor
    }

    render() {
        const { context, x, y, radius, color } = this

        const gradX = x - (radius / 2)
        const gradY = y - (radius / 2)
        const gradientFillStyle = context.createRadialGradient(gradX, gradY, 0, gradX, gradY, radius * 2)
        gradientFillStyle.addColorStop(0, "#FFF")
        gradientFillStyle.addColorStop(0.5, color)
        gradientFillStyle.addColorStop(1, "#000")

        context.beginPath()
        context.arc(x, y, radius, 0, Math.PI * 2)
        context.fillStyle = gradientFillStyle
        context.fill()
        context.closePath()
    }

    update() { }
}
