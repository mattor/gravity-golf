import { getDistBetween } from "./"

export default (sprite1, sprite2) => {
    const dist = getDistBetween(sprite1, sprite2)
    return dist < sprite1.radius + sprite2.radius
}
