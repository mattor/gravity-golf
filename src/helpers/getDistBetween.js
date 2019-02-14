export default (p1, p2) => {
    const xFactor = Math.pow(Math.abs(p1.x - p2.x), 2) || 0
    const yFactor = Math.pow(Math.abs(p1.y - p2.y), 2) || 0
    return Math.sqrt(xFactor + yFactor)
}
