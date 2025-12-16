"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.spaceVertical = exports.spaceHorizontal = exports.normalizeBBox = exports.tick = exports.wait = exports.bboxWithTransform = void 0;
function bboxWithTransform(node) {
    var bbox = node.bbox();
    var matrix = node.matrix();
    return bbox.transform(matrix);
}
exports.bboxWithTransform = bboxWithTransform;
/**
 * Creates a Promise that will be resolved after a specified delay.
 * @param ms Time in milliseconds to wait before resolving promise.
 */
function wait(ms) {
    return new Promise(function (resolve) {
        setTimeout(resolve, ms);
    });
}
exports.wait = wait;
/**
 * Creates a Promise that will be resolved after 0 milliseconds. This is used
 * to create a short delay that allows the browser to address any pending tasks
 * while the JavaScript VM is not active.
 */
function tick() {
    return wait(0);
}
exports.tick = tick;
function normalizeBBox(box) {
    var bbox = box;
    if (bbox.ax == null) {
        bbox.ax = box.x;
    }
    if (bbox.ax2 == null) {
        bbox.ax2 = box.x2;
    }
    if (bbox.ay == null) {
        bbox.ay = box.cy;
    }
    return bbox;
}
exports.normalizeBBox = normalizeBBox;
/**
 * Positions a collection of nodes with their axis points aligned along a
 * horizontal line. This leads to the nodes being spaced horizontally and
 * effectively centered vertically.
 * @param nodes Array of nodes to be positioned
 * @param padding Number of pixels to leave between items
 */
function spaceHorizontal(nodes, padding) {
    var values = nodes.map(function (node) { return ({
        bbox: normalizeBBox(node.bbox()),
        node: node,
    }); });
    // Calculate where the axis points should be positioned vertically.
    var verticalCenter = values.reduce(function (center, _a) {
        var bbox = _a.bbox;
        return Math.max(center, bbox.ay);
    }, 0);
    // Position items with padding between them and aligned their axis points.
    values.reduce(function (offset, _a) {
        var node = _a.node, bbox = _a.bbox;
        node.translate(offset, verticalCenter - bbox.ay);
        return offset + padding + bbox.width;
    }, 0);
}
exports.spaceHorizontal = spaceHorizontal;
/**
 * Positions a collection of nodes centered horizontally in a vertical stack.
 * @param nodes Array of nodes to be positioned
 * @param padding Number of pixels to leave between items
 */
function spaceVertical(nodes, padding) {
    var values = nodes.map(function (node) { return ({
        bbox: node.bbox(),
        node: node,
    }); });
    // Calculate where the center of each item should be positioned horizontally.
    var horizontalCenter = values.reduce(function (center, _a) {
        var bbox = _a.bbox;
        return Math.max(center, bbox.cx);
    }, 0);
    // Position items with padding between them and align their centers.
    values.reduce(function (offset, _a) {
        var node = _a.node, bbox = _a.bbox;
        node.translate(horizontalCenter - bbox.cx, offset);
        return offset + padding + bbox.height;
    }, 0);
}
exports.spaceVertical = spaceVertical;
//# sourceMappingURL=util.js.map