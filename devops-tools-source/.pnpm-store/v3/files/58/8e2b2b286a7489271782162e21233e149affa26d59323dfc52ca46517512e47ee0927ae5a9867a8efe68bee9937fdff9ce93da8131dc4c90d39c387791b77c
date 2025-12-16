"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Node = void 0;
var util_1 = require("./util");
var Node = /** @class */ (function () {
    function Node(metadata, parent) {
        this.metadata = metadata;
        this.state = parent instanceof Node ? parent.state : parent;
    }
    Object.defineProperty(Node.prototype, "type", {
        get: function () {
            return this.metadata.type;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Node.prototype, "text", {
        get: function () {
            return this.metadata.text;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Node.prototype, "offset", {
        get: function () {
            return this.metadata.offset;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Node.prototype, "elements", {
        get: function () {
            return this.metadata.elements;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Node.prototype, "anchor", {
        get: function () {
            return {};
        },
        enumerable: false,
        configurable: true
    });
    Node.prototype.getAnchor = function () {
        if (this.proxy) {
            return this.proxy.getAnchor();
        }
        return this.anchor;
    };
    /**
     * Returns the bounding box of the container with the anchor included
     */
    Node.prototype.bbox = function () {
        var bbox = (0, util_1.bboxWithTransform)(this.container);
        var anchor = this.getAnchor();
        return Object.assign((0, util_1.normalizeBBox)(bbox), anchor);
    };
    Node.prototype.translate = function (tx, ty) {
        return this.container.translate(tx, ty);
    };
    /**
     * Returns a Promise that will be resolved with the provided value. If the
     * render is cancelled before the Promise is resolved, then an exception will
     * be thrown to halt any rendering.
     * @param value Value to resolve the returned promise with.
     * @returns A Promise resolved with the provided value.
     */
    Node.prototype.defer = function (value) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, (0, util_1.tick)()];
                    case 1:
                        _a.sent();
                        if (this.state.cancelRender) {
                            throw new Error('Render cancelled');
                        }
                        return [2 /*return*/, value];
                }
            });
        });
    };
    /**
     * Render this node.
     * @param container Optional element to render this node into. A container
     * must be specified, but if it has already been set, then it does not
     * need to be provided to render.
     */
    Node.prototype.render = function (container) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (container) {
                            this.container = container;
                            this.container.addClass(this.type);
                        }
                        // For nodes that proxy to a child node, just render the child.
                        if (this.proxy) {
                            return [2 /*return*/, this.proxy.render(this.container)];
                        }
                        this.state.inc();
                        return [4 /*yield*/, this.renderNode()];
                    case 1:
                        _a.sent();
                        this.state.dec();
                        return [2 /*return*/, this];
                }
            });
        });
    };
    Node.prototype.renderNode = function () {
        return __awaiter(this, void 0, void 0, function () { return __generator(this, function (_a) {
            return [2 /*return*/];
        }); });
    };
    /**
     * Renders a label centered within a rectangle which can be styled.
     * @param text String or array of strings to render as a label.
     * @returns A Promise which will be resolved with the SVG group the rect and
     * text are rendered in.
     */
    Node.prototype.renderLabel = function (text, options) {
        if (options === void 0) { options = {}; }
        return __awaiter(this, void 0, void 0, function () {
            var group, rect, label, bbox, margin;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        group = this.container.group().addClass('label');
                        rect = group.rect();
                        label = this.renderText(group, text);
                        if (options.className) {
                            group.addClass(options.className);
                        }
                        return [4 /*yield*/, this.defer()];
                    case 1:
                        _a.sent();
                        bbox = label.bbox();
                        margin = 5;
                        label.translate(margin, bbox.height / 2 + 2 * margin);
                        rect.attr({
                            width: bbox.width + 2 * margin,
                            height: bbox.height + 2 * margin,
                        });
                        if (options.round) {
                            rect.attr({ rx: options.round, ry: options.round });
                        }
                        return [2 /*return*/, group];
                }
            });
        });
    };
    /**
     * Renders a labeled box around another SVG element.
     * @param text String or array of strings to label the box with.
     * @param content SVG element to wrap in the box.
     * @param padding Pixels of padding to place between the content and the box.
     */
    Node.prototype.renderLabeledBox = function (text, content, padding) {
        if (padding === void 0) { padding = 0; }
        return __awaiter(this, void 0, void 0, function () {
            var label, rect, labelBox, contentBox, boxWidth, boxHeight;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        label = this.renderText(this.container, text);
                        rect = this.container.rect().attr({ rx: 3, ry: 3 });
                        label.addClass("".concat(this.type, "-label")).back();
                        rect.addClass("".concat(this.type, "-box")).back();
                        return [4 /*yield*/, this.defer()];
                    case 1:
                        _a.sent();
                        labelBox = label.bbox();
                        contentBox = content.bbox();
                        boxWidth = Math.max(contentBox.width + padding * 2, labelBox.width);
                        boxHeight = contentBox.height + padding * 2;
                        label.translate(0, labelBox.height);
                        rect.translate(0, labelBox.height).attr({
                            width: boxWidth,
                            height: boxHeight,
                        });
                        content.translate(boxWidth / 2 - contentBox.cx, labelBox.height + padding);
                        return [2 /*return*/];
                }
            });
        });
    };
    Node.prototype.renderText = function (container, text) {
        var lines = Array.isArray(text) ? text : [text];
        return container.text(function (block) {
            lines.forEach(function (line) { return block.tspan(line); });
        });
    };
    return Node;
}());
exports.Node = Node;
//# sourceMappingURL=node.js.map