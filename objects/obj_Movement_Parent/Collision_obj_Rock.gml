// Block movement when the rock is intact; destroyed rocks have no collision
if (!other.destroyed) {
    collision();
}
