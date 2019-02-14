import { G, earthMass, distScaleFactor, forceMin, forceDelta } from "../const/Config"
import { getDistBetween, getAngleBetween } from "../helpers"

function drawTriangle(context, x, y, radius, rotate) {
    context.beginPath()

    const sides = 3
    const a = ((Math.PI * 2) / sides)

    for (let i = 0; i < sides; i++) {
        context.lineTo(x + radius * Math.cos(a * i + rotate), y + radius * Math.sin(a * i + rotate))
    }

    context.fillStyle = "#FFF"
    context.fill()
}

export default class Spaceship {
    constructor({
        name = "spaceship",
        context,
        x,
        y,
        mass = earthMass / 5,
        launchForce = forceMin,
        launchAngle = 0,
        isDebugging = false,
    } = {}) {
        this.context = context
        this.x = x
        this.y = y
        this.mass = mass
        this.launchForce = launchForce
        this.launchAngle = launchAngle
        this.name = name
        this.isDebugging = isDebugging
        this.isAdjusting = true

        this.radius = 10
    }

    render() {
        const { context, x, y, radius, launchAngle, launchForce, isAdjusting, isDebugging, angle, force } = this

        const launchLineLength = radius + (launchForce / forceDelta)

        if (isAdjusting) {
            context.beginPath()
            context.moveTo(x, y)
            context.lineTo(
                x + Math.cos(launchAngle + Math.PI) * launchLineLength,
                y + Math.sin(launchAngle + Math.PI) * launchLineLength
            )
            context.lineWidth = 4
            context.strokeStyle = "#FF0"
            context.stroke()
        } else if (isDebugging) {
            const isDebuggingLineLength = radius + (5 * force / forceDelta)

            context.beginPath()
            context.moveTo(x, y)
            context.lineTo(
                x + Math.cos(angle) * isDebuggingLineLength,
                y + Math.sin(angle) * isDebuggingLineLength
            )
            context.lineWidth = 2
            context.strokeStyle = "#F00"
            context.stroke()
        }

        drawTriangle(context, x, y, radius, isAdjusting ? launchAngle : angle)
    }

    update(planets) {
        const { mass, force, angle } = this

        let forceTotalX = 0,
            forceTotalY = 0

        planets.forEach(planet => {
            // Newton's Law of Universal Gravitation
            // gravityForce = G * m1 * m2 / dist ^ 2

            const gravityForce = (distScaleFactor * G * planet.mass * mass) / Math.pow(getDistBetween(this, planet), 2)
            const gravityDirection = getAngleBetween(this, planet)

            // Update total force
            forceTotalX += gravityForce * Math.cos(gravityDirection)
            forceTotalY += gravityForce * Math.sin(gravityDirection)
        })

        // Add spaceship's momentum to total force
        forceTotalX += force * Math.cos(angle)
        forceTotalY += force * Math.sin(angle)

        // Update values on spaceship
        this.angle = getAngleBetween({ x: 0, y: 0 }, { x: forceTotalX, y: forceTotalY })
        this.force = getDistBetween({ x: 0, y: 0 }, { x: forceTotalX, y: forceTotalY })
        this.x += forceTotalX
        this.y += forceTotalY
    }
}
