export let rightPressed = false
export let leftPressed = false
export let upPressed = false
export let downPressed = false

let spacePressed = false
let spaceCallback = () => { }

document.addEventListener("keydown", keyDownHandler, false)
document.addEventListener("keyup", keyUpHandler, false)

function keyDownHandler(e) {
    //console.log(e.keyCode)

    switch (e.keyCode) {
        case 39:
            rightPressed = true
            break
        case 37:
            leftPressed = true
            break
        case 40:
            downPressed = true
            break
        case 38:
            upPressed = true
            break
        case 32:
            if (!spacePressed) {
                spacePressed = true
                spaceCallback()
            }
            break
    }
}

function keyUpHandler(e) {
    switch (e.keyCode) {
        case 39:
            rightPressed = false
            break
        case 37:
            leftPressed = false
            break
        case 40:
            downPressed = false
            break
        case 38:
            upPressed = false
            break
        case 32:
            spacePressed = false
            break
    }
}

export const onSpacePressed = callback => {
    spaceCallback = callback
}
