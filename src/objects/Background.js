import "../assets/bg-space.jpg"

import { gameWidth, gameHeight } from "../const/Config"

export default class Background {
    constructor({
        name = "Background",
        context,
        src = "./bg-space.jpg",
    } = {}) {
        this.context = context
        this.name = name

        const image = new Image()
        image.src = src
        image.onload = function (e) {
            this.image = e.target
        }.bind(this)
    }

    render() {
        const { context, image } = this

        if (image) {
            context.drawImage(image, 0, 0, gameWidth, gameHeight)
        }
    }

    update() { }
}
