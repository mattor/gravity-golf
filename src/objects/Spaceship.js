import { G, earthMass, distScaleFactor, momentumMin, momentumDelta } from "../const/Config"
import { getDistBetween, getAngleBetween } from "../helpers"

function drawTriangle(context, x, y, radius, rotate) {
    context.beginPath()

    const sides = 3
    const a = ((Math.PI * 2) / sides)

    for (let i = 0; i < sides; i++) {
        context.lineTo(x + radius * Math.cos(a * i + rotate - a), y + radius * Math.sin(a * i + rotate - a))
    }

    context.fillStyle = "#000"
    context.lineWidth = 2
    context.strokeStyle = "#FFF"
    context.fill()
    context.stroke()
}

export default class Spaceship {
    constructor({
        name = "spaceship",
        context,
        x,
        y,
        mass = earthMass / 5,
        launchMomentum = momentumMin,
        launchAngle = 0,
        isDebugging = false,
    } = {}) {
        this.context = context
        this.x = x
        this.y = y
        this.mass = mass
        this.launchMomentum = launchMomentum
        this.launchAngle = launchAngle
        this.name = name
        this.isDebugging = isDebugging
        this.isAdjusting = true

        this.radius = 10
    }

    render() {
        const { context, x, y, radius, launchAngle, launchMomentum, isAdjusting, isDebugging, angle, momentum } = this

        const launchLineLength = radius + (launchMomentum / momentumDelta)

        if (isAdjusting) {
            context.beginPath()
            context.moveTo(x, y)
            context.lineTo(
                x + Math.cos(launchAngle + Math.PI) * launchLineLength,
                y + Math.sin(launchAngle + Math.PI) * launchLineLength,
            )
            context.lineWidth = 4
            context.strokeStyle = "#00C0E0"
            context.stroke()
        } else if (isDebugging) {
            const isDebuggingLineLength = radius + (5 * momentum / momentumDelta)

            context.beginPath()
            context.moveTo(x, y)
            context.lineTo(
                x + Math.cos(angle) * isDebuggingLineLength,
                y + Math.sin(angle) * isDebuggingLineLength,
            )
            context.lineWidth = 2
            context.strokeStyle = "#F00"
            context.stroke()
        }

        drawTriangle(context, x, y, radius, isAdjusting ? launchAngle : angle)
    }

    update(planets) {
        const { mass, momentum, angle } = this

        let momentumTotalX = 0,
            momentumTotalY = 0

        planets.forEach(planet => {
            // Newton's Law of Universal Gravitation
            // gravitymomentum = G * m1 * m2 / dist ^ 2

            const gravitymomentum = (distScaleFactor * G * planet.mass * mass) / Math.pow(getDistBetween(this, planet), 2)
            const gravityDirection = getAngleBetween(this, planet)

            // Update total momentum
            momentumTotalX += gravitymomentum * Math.cos(gravityDirection)
            momentumTotalY += gravitymomentum * Math.sin(gravityDirection)
        })

        // Add spaceship's momentum to total momentum
        momentumTotalX += momentum * Math.cos(angle)
        momentumTotalY += momentum * Math.sin(angle)

        // Update values on spaceship
        this.angle = getAngleBetween({ x: 0, y: 0 }, { x: momentumTotalX, y: momentumTotalY })
        this.momentum = getDistBetween({ x: 0, y: 0 }, { x: momentumTotalX, y: momentumTotalY })
        this.x += momentumTotalX
        this.y += momentumTotalY
    }
}
